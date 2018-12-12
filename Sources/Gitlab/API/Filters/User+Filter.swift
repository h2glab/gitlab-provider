public extension User {
    public struct Filter: Codable {
        
        var per_page: Int = 20
        
        public init() { }
    }
}

public extension User.Filter {
    
    public var builder: Builder {
        return Builder()
    }
    
    public class Builder {
        
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
