public extension Issue {
    public struct Filter: Codable {
        
        public enum State: String, Codable {
            case opened
            case closed
        }
        
        var per_page: Int = 20
        /// Return all issues or just those that are opened or closed
        var state: State? = nil
        /// Comma-separated list of label names, issues must have all labels to be returned. None lists all issues with no labels. Any lists all issues with at least one label. No+Label (Deprecated) lists all issues with no labels. Predefined names are case-insensitive.
        var labels: String? = nil
        /// The milestone title. None lists all issues with no milestone. Any lists all issues that have an assigned milestone.
        var milestone: String? = nil
        /// Return issues for the given scope: created_by_me, assigned_to_me or all. Defaults to created_by_me
        /// For versions before 11.0, use the now deprecated created-by-me or assigned-to-me scopes instead.
        /// (Introduced in GitLab 9.5. Changed to snake_case in GitLab 11.0)
        var scope: String? = nil
        /// Return issues created by the given user id. Combine with scope=all or scope=assigned_to_me. (Introduced in GitLab 9.5)
        var author_id: Int? = nil
        /// Return issues assigned to the given user id. None returns unassigned issues. Any returns issues with an assignee. (Introduced in GitLab 9.5)
        var assignee_id: Int? = nil
        /// Return issues reacted by the authenticated user by the given emoji. None returns issues not given a reaction. Any returns issues given at least one reaction. (Introduced in GitLab 10.0)
        var my_reaction_emoji: String? = nil
        /// Return issues with the specified weight. None returns issues with no weight assigned. Any returns issues with a weight assigned.
        var weight: Int? = nil
        /// Return only the issues having the given iid
        var iids: [Int]? = nil
        /// Return issues ordered by created_at or updated_at fields. Default is created_at
        var order_by: String? = nil
        /// Return issues sorted in asc or desc order. Default is desc
        var sort: String? = nil
        /// Search issues against their title and description
        var search: String? = nil
        /// Return issues created on or after the given time
        // TODO Change to datetime
        var created_after: String? = nil
        /// Return issues created on or before the given time
        // TODO Change to datetime
        var created_before: String? = nil
        /// Return issues updated on or after the given time
        // TODO Change to datetime
        var updated_after: String? = nil
        /// Return issues updated on or before the given time
        // TODO Change to datetime
        var updated_before: String? = nil
        
        public init() { }
    }
}

public extension Issue.Filter {
    
    public var builder: Builder {
        return Builder()
    }
    
    public class Builder {
        
        private var filter: Issue.Filter
        
        public init() {
            filter = Issue.Filter()
        }
        
        public func withPerPage(_ perPage: Int) -> Builder {
            filter.per_page = perPage
            return self
        }
        
        public func withState(_ state: Issue.Filter.State) -> Builder {
            filter.state = state
            return self
        }
        
        public func withMilestone(_ milestone: String) -> Builder {
            filter.milestone = milestone
            return self
        }
        
        public func withAssigneeId(_ assigneeId: Int) -> Builder {
            filter.assignee_id = assigneeId
            return self
        }
        
        public func withLabels(_ labels: [String]) -> Builder {
            filter.labels = labels.joined(separator: ",")
            return self
        }
        
        public func build() -> Issue.Filter {
            return filter
        }
    }
}
