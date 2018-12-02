import XCTest

import GitlabTests

var tests = [XCTestCaseEntry]()
tests += GitlabTests.allTests()
XCTMain(tests)