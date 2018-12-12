import Vapor

public protocol ProjectRoutes {
    func list(filter: Project.Filter?) throws -> Future<Page<Project>>
    func listMiletstones(projectId: Project.ID, filter: Milestone.Filter?) throws -> Future<Page<Milestone>>
    func listLabels(projectId: Project.ID) throws -> Future<Page<Label>>
}

public struct GitlabProjectRoutes: ProjectRoutes {
    private let request: GitlabRequest
    
    init(request: GitlabRequest) {
        self.request = request
    }
    
    /// List projects
    /// [Learn More →](https://docs.gitlab.com/ee/api/projects.html#list-all-projects)
    public func list(filter: Project.Filter?) throws -> Future<Page<Project>> {
        
        let queryParams = filter?.dictionary.queryParameters ?? ""
        return try request.sendList(method: .GET, path: GitlabAPIEndpoint.projects.endpoint, query: queryParams)
    }
    
    /// List project milestones
    /// [Learn More →](https://docs.gitlab.com/ee/api/milestones.html#list-project-milestones)
    public func listMiletstones(projectId: Project.ID, filter: Milestone.Filter?) throws -> Future<Page<Milestone>> {
    
        let queryParams = filter?.dictionary.queryParameters ?? ""
        return try request.sendList(method: .GET, path: GitlabAPIEndpoint.projectMilestones(projectId).endpoint, query: queryParams)
    }
    
    /// List project labels
    /// [Learn More →](https://docs.gitlab.com/ee/api/labels.html#list-labels)
    public func listLabels(projectId: Project.ID) throws -> Future<Page<Label>> {
        
        return try request.sendList(method: .GET, path: GitlabAPIEndpoint.projectLabels(projectId).endpoint, query: "")
    }
}
