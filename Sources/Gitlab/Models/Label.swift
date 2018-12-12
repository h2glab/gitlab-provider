public struct Label: GitlabModel {
    
    public typealias ID = Int
    
    public let id: ID
    public let name: String
    public let color: String
    public let description: String?
    public let openIssuesCount: Int
    public let closedIssuesCount: Int
    public let openMergeRequestsCount: Int
    public let subscribed: Bool
    public let priority: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, color, description
        case openIssuesCount = "open_issues_count"
        case closedIssuesCount = "closed_issues_count"
        case openMergeRequestsCount = "open_merge_requests_count"
        case subscribed, priority
    }
}
