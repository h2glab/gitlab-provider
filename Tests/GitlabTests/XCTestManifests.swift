import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(GitlabTests.allTests),
        testCase(IssueTests.allTests),
    ]
}
#endif