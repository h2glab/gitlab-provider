public extension User {
    struct Filter: Codable {
        
        var per_page: Int = 20
        
        public init() { }
    }
}

public extension User.Filter {
    
    var builder: Builder {
        return Builder()
    }
    
    class Builder {
        
        private var filter: User.Filter
        
        public init() {
            filter = User.Filter()
        }
        
        public func withPerPage(_ perPage: Int) -> Builder {
            filter.per_page = perPage
            return self
        }
        
        public func build() -> User.Filter {
            return filter
        }
    }
}
