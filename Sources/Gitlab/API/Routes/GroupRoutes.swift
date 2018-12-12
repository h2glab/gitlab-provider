import Vapor

public protocol GroupRoutes {
    func list(filter: Group.Filter?) throws -> Future<Page<Group>>
    func listProjects(groupId: Group.ID, filter: Project.Filter?) throws -> Future<Page<Project>>
    func listMilestones(groupId: Group.ID, filter: Milestone.Filter?) throws -> Future<Page<Milestone>>
    func listMilestoneIssues(groupId: Group.ID, milestoneId: Milestone.ID) throws -> Future<Page<Issue>>
}

public struct GitlabGroupRoutes: GroupRoutes {

    private let request: GitlabRequest
    
    init(request: GitlabRequest) {
        self.request = request
    }
    
    /// List groups
    /// [Learn More →](https://docs.gitlab.com/ee/api/groups.html#list-groups)
    public func list(filter: Group.Filter?) throws -> Future<Page<Group>> {
        
        let queryParams = filter?.dictionary.queryParameters ?? ""
        return try request.sendList(method: .GET, path: GitlabAPIEndpoint.groups.endpoint, query: queryParams)
    }
    
    /// List a group's projects
    /// [Learn More →](https://docs.gitlab.com/ee/api/groups.html#list-a-groups-projects)
    public func listProjects(groupId: Group.ID, filter: Project.Filter?) throws -> Future<Page<Project>> {
        
        let queryParams = filter?.dictionary.queryParameters ?? ""
        return try request.sendList(method: .GET, path: GitlabAPIEndpoint.groupProjects(groupId).endpoint, query: queryParams)
    }
    
    /// List group milestones
    /// [Learn More →](https://docs.gitlab.com/ee/api/group_milestones.html#list-group-milestones)
    public func listMilestones(groupId: Group.ID, filter: Milestone.Filter?) throws -> Future<Page<Milestone>> {
        
        let queryParams = filter?.dictionary.queryParameters ?? ""
        return try request.sendList(method: .GET, path: GitlabAPIEndpoint.groupMilestones(groupId).endpoint, query: queryParams)
    }
    
    /// Get all issues assigned to a single milestone
    /// [Learn More →](https://docs.gitlab.com/ee/api/group_milestones.html#get-all-issues-assigned-to-a-single-milestone)
    public func listMilestoneIssues(groupId: Group.ID, milestoneId: Milestone.ID) throws -> Future<Page<Issue>> {

        return try request.sendList(method: .GET, path: GitlabAPIEndpoint.groupMilestoneIssues(groupId, milestoneId).endpoint, query: "")
    }
}
