
public extension Group {
    struct Filter: Codable {
        
        var per_page: Int = 20
        
        public init() { }
    }
}

public extension Group.Filter {
    
    var builder: Builder {
        return Builder()
    }
    
    class Builder {
        
        private var filter: Group.Filter
        
        public init() {
            filter = Group.Filter()
        }
        
        public func withPerPage(_ perPage: Int) -> Builder {
            filter.per_page = perPage
            return self
        }
        
        public func build() -> Group.Filter {
            return filter
        }
    }
}
