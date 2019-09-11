import Foundation

extension Webhook {
    public struct IssueAttributes: Codable {
        public let id: Int
        public let title: String
        public let assignee_ids: [Int]
        public let assignee_id: Int?
        public let author_id: Int
        public let project_id: Int
        public let created_at: String
        public let updated_at: String
        public let position: Int?
        public let branch_name: String?
        public let description: String
        public let milestone_id: Int?
        public let state: String
        public let iid: Int
        public let url: URL
        public let action: String?
        public let total_time_spent: Int?
        public let time_estimate: Int?
    }
    
    public struct Issue: WebhookResponse, Codable {
        public let object_kind: String
        public let event_type: String?
        public let user: User
        public let project: Project
        public let object_attributes: IssueAttributes
        public let assignees: [User]?
        public let labels: [Label]?
    }
}
