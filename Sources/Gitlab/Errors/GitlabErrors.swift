import Foundation
import Vapor

public struct GitlabError: GitlabModel, Error, Debuggable {
    public var identifier: String {
        return self.error
    }
    public var reason: String {
        return self.error
    }
    public var error: String
}