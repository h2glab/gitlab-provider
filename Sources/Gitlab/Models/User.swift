import Foundation

public struct User: GitlabModel {

    public let id: Int
    public let name: String
    public let username: String
    public let avatarUrl: URL?

    private enum CodingKeys: String, CodingKey {
        case id, name, username
        case avatarUrl = "avatar_url"
    }

}
