import Swift

extension Webhook {
    public struct Label: Codable {
        public let id: Int
        public let title: String
        public let color: String
        public let project_id: Int
        public let created_at: String
        public let updated_at: String
        public let template: Bool
        public let description: String?
        public let type: String
        public let group_id: Int?
    }
}
