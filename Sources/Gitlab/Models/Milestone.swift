import Foundation

public struct Milestone: GitlabModel {

    public typealias ID = Int
    
    public enum State: String, Codable {
        case active
        case closed
    }
    
    public let id: ID
    public let title: String
    public let state: State
    public let dueDate: Date?
    public let startDate: Date?

    private enum CodingKeys: String, CodingKey {
        case id, title, state
        case dueDate = "due_date"
        case startDate = "start_date"
    }
}
