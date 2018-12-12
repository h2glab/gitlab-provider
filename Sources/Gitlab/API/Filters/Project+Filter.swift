
public extension Project {
    public struct Filter: Codable {
        
        var per_page: Int = 20
        /// Limit by archived status.
        var archived: Bool? = nil
        /// Limit by enabled issues feature.
        var with_issues_enabled: Bool? = nil
        
        public init() { }
    }
}

public extension Project.Filter {
    
    public var builder: Builder {
        return Builder()
    }
    
    public class Builder {
        
        private var filter: Project.Filter
        
        public init() {
            filter = Project.Filter()
        }
        
        public func withPerPage(_ perPage: Int) -> Builder {
            filter.per_page = perPage
            return self
        }
        
        public func withArchived(_ archived: Bool) -> Builder {
            filter.archived = archived
            return self
        }
        
        public func withIssueEnabled(_ issueEnabled: Bool) -> Builder {
            filter.with_issues_enabled = issueEnabled
            return self
        }
        
        public func build() -> Project.Filter {
            return filter
        }
    }
}
