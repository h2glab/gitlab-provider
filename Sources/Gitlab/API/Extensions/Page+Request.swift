import Vapor

extension Page {
    
    init(pagination: PaginationData, content: [GitlabModel]) {
        self.totalItemCount = pagination.totalItemCount
        self.itemCountPerPage = pagination.itemCountPerPage
        self.totalPageCount = pagination.totalPageCount
        self.currentPageIndex = pagination.currentPageIndex
        self.nextPageIndex = pagination.nextPageIndex
        self.prevPageIndex = pagination.prevPageIndex
        
        self.content = content
    }
}

extension HTTPHeaders {

    func gitlabPagination() -> Either<String, PaginationData> {
        guard let totalItemCount = self.optInt("X-Total"),
            let totalPageCount = self.optInt("X-Total-Pages"),
            let itemCountPerPage = self.optInt("X-Per-Page"),
            let currentPageIndex = self.optInt("X-Page") else {
                return Either.left("Missing header information")
        }
        
        let nextPageIndex = self.optInt("X-Next-Page")
        let prevPageIndex = self.optInt("X-Prev-Page")
        
        return Either.right(PaginationData(totalItemCount: totalItemCount,
                                           itemCountPerPage: itemCountPerPage,
                                           totalPageCount: totalPageCount,
                                           currentPageIndex: currentPageIndex,
                                           nextPageIndex: nextPageIndex,
                                           prevPageIndex: prevPageIndex))
    }
    func optInt(_ key: String) -> Int? {
        guard let first = self[key].first else {
            return nil
        }
        
        return Int(first)
    }
}

struct PaginationData {
    let totalItemCount: Int
    let itemCountPerPage: Int
    let totalPageCount: Int
    let currentPageIndex: Int
    let nextPageIndex: Int?
    let prevPageIndex: Int?
}
