import Foundation

internal let APIVersion = "api/v4/"

internal enum GitlabAPIEndpoint {
    
    // MARK: - ISSUES
    case issues

    // MARK: - USERS
    case users
    
    // MARK: - PROJECTS
    case projects
    case projectMilestones(Project.ID)
    case projectMilestoneIssues(Project.ID, Milestone.ID)
    case projectLabels(Label.ID)
    
    // MARK: - GROUPS
    case groups
    case group(Group.ID)
    case groupProjects(Group.ID)
    case groupMilestones(Group.ID)
    case groupMilestoneIssues(Group.ID, Milestone.ID)
    
    var endpoint: String {
        switch self {
        case .issues: return APIVersion + "issues"

        case .users: return APIVersion + "users"

        case .projects: return APIVersion + "projects"
        case .projectMilestones(let projectId): return APIVersion + "projects/\(projectId)/milestones"
        case .projectMilestoneIssues(let projectId, let milestoneId): return APIVersion + "projects/\(projectId)/milestones/\(milestoneId)/issues"
        case .projectLabels(let projectId): return APIVersion + "projects/\(projectId)/labels"
        
        case .groups: return APIVersion + "groups"
        case .group(let groupId): return APIVersion + "groups/\(groupId)"
        case .groupProjects(let groupId) : return APIVersion + "/groups/\(groupId)/projects"
        case .groupMilestones(let groupId): return APIVersion + "groups/\(groupId)/milestones"
        case .groupMilestoneIssues(let groupId, let milestoneId): return APIVersion + "groups/\(groupId)/milestones/\(milestoneId)/issues"
        }
    }
}
