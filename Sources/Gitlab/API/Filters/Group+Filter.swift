
public extension Group {
    public struct Filter: Codable {
        
        var per_page: Int = 20
        
        public init() { }
    }
}

public extension Group.Filter {
    
    public var builder: Builder {
        return Builder()
    }
    
    public class Builder {
        
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
