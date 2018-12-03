import Foundation

public struct IssueList: GitlabModel {

    public let page: Int
    public let nextPage: Int?
    public let prevPage: Int?
    public let total: Int
    public let totalPages: Int
    public let content: [Issue]

    public enum CodingKeys: String, CodingKey {
        case page, nextPage, prevPage, total, totalPages, content
    }
}
