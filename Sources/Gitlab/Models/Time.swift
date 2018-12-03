import Foundation

public struct Time: GitlabModel {

    public let timeEstimate: Int
    public let totalTimeSpent: Int

    private enum CodingKeys: String, CodingKey {
        case timeEstimate = "time_estimate"
        case totalTimeSpent = "total_time_spent"
    }
}
