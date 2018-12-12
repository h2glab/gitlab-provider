import Vapor

public protocol IssueRoutes {
    func list(filter: Issue.Filter?) throws -> Future<Page<Issue>>
}

public struct GitlabIssueRoutes: IssueRoutes {
    private let request: GitlabRequest

    init(request: GitlabRequest) {
        self.request = request
    }

    /// List all issues
    /// [Learn More →](https://docs.gitlab.com/ee/api/issues.html#list-issues)
    public func list(filter: Issue.Filter?) throws -> Future<Page<Issue>> {
        var urlParser = URLComponents()
        urlParser.queryItems = filter.dictionary.map { key, value in URLQueryItem(name: key, value: "\(value)") }
        let httpBodyString = urlParser.percentEncodedQuery
        let pathEncoded = httpBodyString?.replacingOccurrences(of: ":", with: "%3A") ?? ""
        return try request.sendList(method: .GET, path: GitlabAPIEndpoint.issues.endpoint, query: pathEncoded)
    }
}
