import Vapor

public protocol IssueRoutes {
    func listAll(filter: [String: Any]?) throws -> Future<IssueList>
}

public struct GitlabIssueRoutes: IssueRoutes {
    private let request: GitlabRequest

    init(request: GitlabRequest) {
        self.request = request
    }

    /// List all issues
    /// [Learn More →](https://docs.gitlab.com/ee/api/issues.html#list-issues)
    public func listAll(filter: [String : Any]?) throws -> Future<IssueList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try request.send(method: .GET, path: GitlabAPIEndpoint.issues.endpoint, query: queryParams)
    }
}