import Foundation

public struct Milestone: GitlabModel {

    public let id: Int
    public let title: String
    public let state: String
    public let dueDate: Date?
    public let startDate: Date?

    private enum CodingKeys: String, CodingKey {
        case id, title, state
        case dueDate = "due_date"
        case startDate = "start_date"
    }
}
