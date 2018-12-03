import Foundation

public struct Issue: GitlabModel {

    public let id: Int
    public let title: String
    public let projectId: Int
    public let description: String?
    public let state: String
    public let createdAt: Date
    public let updatedAt: Date?
    public let closedAt: Date?
    public let labels: [String]?
    public let milestone: Milestone?
    public let assignees: [User]?
    public let author: User
    public let timeStats: Time
    public let webUrl: URL

    private enum CodingKeys: String, CodingKey {
        case id, title, description, state, labels
        case milestone, assignees, author
        case projectId = "project_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case closedAt = "closed_at"
        case timeStats = "time_stats"
        case webUrl = "web_url"
    }
}
