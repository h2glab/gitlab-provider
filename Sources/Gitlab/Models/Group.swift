import Foundation

public struct Group: GitlabModel {
    
    public typealias ID = Int
    
    public let id: ID
    public let name: String
    public let path: String
    public let description: String
    public let visibility: String
    public let lfsEnabled: Bool?
    public let avatarUrl: URL?
    public let webUrl: URL?
    public let requestAccessEnabled: Bool
    public let fullName: String
    public let fullPath: String
    public let fileTemplateProjectId: Int?
    public let parentId: Int?
    
    private enum CodingKeys: String, CodingKey {
        case id, name, path, description, visibility
        case lfsEnabled = "lfs_enabled"
        case avatarUrl = "avatar_url"
        case webUrl = "web_url"
        case requestAccessEnabled = "request_access_enabled"
        case fullName = "full_name"
        case fullPath = "full_path"
        case fileTemplateProjectId = "file_template_project_id"
        case parentId = "parent_id"
    }
}
