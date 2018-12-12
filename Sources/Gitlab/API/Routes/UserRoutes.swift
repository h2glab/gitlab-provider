import Vapor

public protocol UserRoutes {
    func list(filter: User.Filter?) throws -> Future<Page<User>>
}

public struct GitlabUserRoutes: UserRoutes {
    private let request: GitlabRequest
    
    init(request: GitlabRequest) {
        self.request = request
    }
    
    /// List all users
    /// [Learn More →](https://docs.gitlab.com/ee/api/users.html)
    public func list(filter: User.Filter?) throws -> Future<Page<User>> {

        let queryParams = filter?.dictionary.queryParameters ?? ""
        return try request.sendList(method: .GET, path: GitlabAPIEndpoint.users.endpoint, query: queryParams)
    }
}
