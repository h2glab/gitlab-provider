import Foundation
import HTTP
import Vapor

public protocol GitlabRequest: class {
    func serializedResponse<GM: GitlabModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<GM>
    func send<GM: GitlabModel>(method: HTTPMethod, path: String, query: String, body: LosslessHTTPBodyRepresentable, headers: HTTPHeaders) throws -> Future<GM>
    func sendList<GM: GitlabModel>(method: HTTPMethod, path: String, query: String, body: LosslessHTTPBodyRepresentable, headers: HTTPHeaders) throws -> Future<Page<GM>>
}

public extension GitlabRequest {
    public func send<GM: GitlabModel>(method: HTTPMethod, path: String, query: String = "", body: LosslessHTTPBodyRepresentable = HTTPBody(string: ""), headers: HTTPHeaders = [:]) throws -> Future<GM> {
        return try send(method: method, path: path, query: query, body: body, headers: headers)
    }

    public func sendList<GM: GitlabModel>(method: HTTPMethod, path: String, query: String = "", body: LosslessHTTPBodyRepresentable = HTTPBody(string: ""), headers: HTTPHeaders = [:]) throws -> Future<Page<GM>> {
        return try sendList(method: method, path: path, query: query, body: body, headers: headers)
    }
    
    public func serializedResponse<GM: GitlabModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<GM> {
        let decoder = GitlabJSONDecoder()

        guard response.status == .ok else {
            return try decoder.decode(GitlabError.self, from: response, maxSize: 65_536, on: worker).map(to: GM.self) { error in
                throw error
            }
        }

        return try decoder.decode(GM.self, from: response, maxSize: 65_536, on: worker)
    }
    
    public func serializedResponseList<GM: GitlabModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<Page<GM>> {
        let decoder = GitlabJSONDecoder()
        
        guard response.status == .ok else {
            return try decoder.decode(GitlabError.self, from: response, maxSize: 65_536, on: worker)
                .map(to: Page<GM>.self) { error in throw error }
        }
        
        return try decoder.decode([GM].self, from: response, maxSize: 65_536, on: worker)
            .map { content in
                let pagination = response.headers.gitlabPagination()
                switch (pagination) {
                case .left(let error): throw GitlabError(error: error)
                case .right(let pagination): return Page(pagination: pagination, content: content)
                }
            }
    }
}

extension HTTPHeaderName {
    public static var privateToken: HTTPHeaderName {
        return .init("Private-Token")
    }
}

extension HTTPHeaders {
    public static var gitlabDefault: HTTPHeaders {
        var headers: HTTPHeaders = [:]
        headers.replaceOrAdd(name: .contentType, value: MediaType.urlEncodedForm.description)
        return headers
    }
}

public class GitlabAPIRequest: GitlabRequest {
    private let httpClient: Client
    private let serverUrl: URL
    private let privateToken: String

    init(httpClient: Client, serverUrl: URL, privateToken: String) {
        self.httpClient = httpClient
        self.serverUrl = serverUrl
        self.privateToken = privateToken
    }

    public func send<GM: GitlabModel>(method: HTTPMethod, path: String, query: String, body: LosslessHTTPBodyRepresentable, headers: HTTPHeaders) throws -> Future<GM> {
        var finalHeaders: HTTPHeaders = .gitlabDefault
        finalHeaders.add(name: .privateToken, value: privateToken)
        headers.forEach {
            finalHeaders.replaceOrAdd(name: $0.name, value: $0.value)
        }

        return httpClient.send(method, headers: finalHeaders, to: "\(serverUrl)/\(path)?\(query)") { (request: Request) in
            return request.http.body = body.convertToHTTPBody()
        }.flatMap(to: GM.self) { (response) -> Future<GM> in
            return try self.serializedResponse(response: response.http, worker: self.httpClient.container.eventLoop)
        }
    }
    
    public func sendList<GM: GitlabModel>(method: HTTPMethod, path: String, query: String, body: LosslessHTTPBodyRepresentable, headers: HTTPHeaders) throws -> Future<Page<GM>> {
        var finalHeaders: HTTPHeaders = .gitlabDefault
        finalHeaders.add(name: .privateToken, value: privateToken)
        headers.forEach {
            finalHeaders.replaceOrAdd(name: $0.name, value: $0.value)
        }
        
        return httpClient.send(method, headers: finalHeaders, to: "\(serverUrl)/\(path)?\(query)") { (request: Request) in return request.http.body = body.convertToHTTPBody() }
            .flatMap(to: Page<GM>.self) { response in return try self.serializedResponseList(response: response.http, worker: self.httpClient.container.eventLoop) }
    }
}
