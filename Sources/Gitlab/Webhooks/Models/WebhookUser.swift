import Foundation

extension Webhook {
    public struct User: Codable {
        public let id: Int?
        public let name: String
        public let username: String
        public let avatar_url: URL
    }
}
