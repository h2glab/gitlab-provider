public extension Milestone {
    struct Filter: Codable {
        
        /// Return only active or closed milestones.
        var state: State? = nil
        
        public init() { }
    }
}

public extension Milestone.Filter {
    
    var builder: Builder {
        return Builder()
    }
    
    class Builder {
        
        private var filter: Milestone.Filter
        
        public init() {
            filter = Milestone.Filter()
        }
        
        public func withState(_ state: Milestone.State) -> Builder {
            filter.state = state
            return self
        }
        
        public func build() -> Milestone.Filter {
            return filter
        }
    }
}
