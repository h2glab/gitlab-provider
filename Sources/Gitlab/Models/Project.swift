import Foundation

public struct Project: GitlabModel {
    
    public typealias ID = Int
    
    public let id: ID
    public let description: String?
    public let defaultBranch: String?
    public let sshUrlToRepo: URL
    public let httpUrlToRepo: URL
    public let webUrl: URL
    public let readmeUrl: URL?
    public let tagList: [String]
    public let name: String
    public let nameWithNamespace: String
    public let path: String
    public let pathWithNamespace: String
    public let createdAt: Date
    public let lastActivityAt: Date?
    public let forksCount: Int
    public let avatarUrl: String?
    public let starCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, description, name, path
        case defaultBranch = "default_branch"
        case sshUrlToRepo = "ssh_url_to_repo"
        case httpUrlToRepo = "http_url_to_repo"
        case webUrl = "web_url"
        case readmeUrl = "readme_url"
        case tagList = "tag_list"
        case nameWithNamespace = "name_with_namespace"
        case pathWithNamespace = "path_with_namespace"
        case createdAt = "created_at"
        case lastActivityAt = "last_activity_at"
        case forksCount = "forks_count"
        case avatarUrl = "avatar_url"
        case starCount = "star_count"
    }
}

