import Foundation

internal let APIVersion = "v4/"

internal enum GitlabAPIEndpoint {

    // MARK: - ISSUES
    case issues

    var endpoint: String {
        switch self {
        case .issues: return APIVersion + "issues"
        }
    }
}