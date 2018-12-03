import Foundation
import HTTP
import Vapor

public protocol GitlabRequest: class {
    func serializedResponse<GM: GitlabModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<GM>
    func send<GM: GitlabModel>(method: HTTPMethod, path: String, query: String, body: LosslessHTTPBodyRepresentable, headers: HTTPHeaders) throws -> Future<GM>
}

public extension GitlabRequest {
    public func send<GM: GitlabModel>(method: HTTPMethod, path: String, query: String = "", body: LosslessHTTPBodyRepresentable = HTTPBody(string: ""), headers: HTTPHeaders = [:]) throws -> Future<GM> {
        return try send(method: method, path: path, query: query, body: body, headers: headers)
    }

    public func serializedResponse<GM: GitlabModel>(response: HTTPResponse, worker: EventLoop) throws -> Future<GM> {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
            let container = try decoder.singleValueContainer()
            let dateStr = try container.decode(String.self)
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
            if let date = formatter.date(from: dateStr) {
                return date
            }

            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: dateStr) {
                return date
            }
            fatalError("To be fixed")
        })

        guard response.status == .ok else {
            return try decoder.decode(GitlabError.self, from: response, maxSize: 65_536, on: worker).map(to: GM.self) { error in
                throw error
            }
        }

        return try decoder.decode(GM.self, from: response, maxSize: 65_536, on: worker)
    }
}

extension HTTPHeaderName {
    public static var gitlabPrivateToken: HTTPHeaderName {
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
        finalHeaders.add(name: .gitlabPrivateToken, value: privateToken)
        headers.forEach {
            finalHeaders.replaceOrAdd(name: $0.name, value: $0.value)
        }

        return httpClient.send(method, headers: finalHeaders, to: "\(serverUrl)/\(path)?\(query)") { request in
            request.http.body = body.convertToHTTPBody()
        }.flatMap(to: GM.self) { (response) -> Future<GM> in
            return try self.serializedResponse(response: response.http, worker: self.httpClient.container.eventLoop)
        }
    }
}