import Foundation

extension Webhook {
    public struct Project: Codable {
        public let id: Int
        public let name: String
        public let web_url: URL
        public let avatar_url: URL?
        public let git_ssh_url: URL
        public let git_http_url: URL
        public let namespace: String
        public let visibility_level: Int
        public let path_with_namespace: String
        public let default_branch: String
        public let homepage: URL
        public let url: URL
    }
}
