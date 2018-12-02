import XCTest
@testable import Gitlab

final class GitlabTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Gitlab().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
