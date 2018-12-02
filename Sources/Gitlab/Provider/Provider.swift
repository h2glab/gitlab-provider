import Foundation
import Vapor

public struct GitlabConfig: Service {
    public let serverUrl: URL
    public let privateToken: String

    public init(serverUrl: URL,privateToken: String) {
        self.serverUrl = serverUrl
        self.privateToken = privateToken
    }
}

public final class GitlabProvider: Provider {
    public static let repositoryName = "gitlab-provider"

    public init() { }

    public func boot(_ worker: Container) throws { }

    public func didBoot(_ worker: Container) throws -> EventLoopFuture<Void> {
        return .done(on: worker)
    }

    public func register(_ services: inout Services) throws {
        services.register { (container) -> GitlabClient in
            let httpClient = try container.make(Client.self)
            let config = try container.make(GitlabConfig.self)
            return GitlabClient(serverUrl: config.serverUrl, privateToken: config.privateToken, client: httpClient)
        }
    }
}

public final class GitlabClient: Service {
    private let serverUrl: URL
    private let privateToken: String
    private let client: Client

    internal init(serverUrl: URL, privateToken: String, client: Client) {
        self.serverUrl = serverUrl
        self.privateToken = privateToken
        self.client = client
    }
}