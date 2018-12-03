import XCTest
@testable import Gitlab
@testable import Vapor

class IssueTests: XCTestCase {
    let issueString = """
                        {
                            "state" : "opened",
                            "description" : "Ratione dolores corrupti mollitia soluta quia.",
                            "author" : {
                                "state" : "active",
                                "id" : 18,
                                "web_url" : "https://gitlab.example.com/eileen.lowe",
                                "name" : "Alexandra Bashirian",
                                "avatar_url" : null,
                                "username" : "eileen.lowe"
                            },
                            "milestone" : {
                                "project_id" : 1,
                                "description" : "Ducimus nam enim ex consequatur cumque ratione.",
                                "state" : "closed",
                                "due_date" : null,
                                "iid" : 2,
                                "created_at" : "2016-01-04T15:31:39.996Z",
                                "title" : "v4.0",
                                "id" : 17,
                                "updated_at" : "2016-01-04T15:31:39.996Z"
                            },
                            "project_id" : 1,
                            "assignees" : [{
                                "state" : "active",
                                "id" : 1,
                                "name" : "Administrator",
                                "web_url" : "https://gitlab.example.com/root",
                                "avatar_url" : null,
                                "username" : "root"
                            }],
                            "assignee" : {
                                "state" : "active",
                                "id" : 1,
                                "name" : "Administrator",
                                "web_url" : "https://gitlab.example.com/root",
                                "avatar_url" : null,
                                "username" : "root"
                            },
                            "updated_at" : "2016-01-04T15:31:51.081Z",
                            "closed_at" : null,
                            "closed_by" : null,
                            "id" : 76,
                            "title" : "Consequatur vero maxime deserunt laboriosam est voluptas dolorem.",
                            "created_at" : "2016-01-04T15:31:51.081Z",
                            "iid" : 6,
                            "labels" : [],
                            "user_notes_count": 1,
                            "due_date": "2016-07-22",
                            "web_url": "http://example.com/example/example/issues/6",
                            "confidential": false,
                            "weight": null,
                            "discussion_locked": false,
                            "time_stats": {
                                "time_estimate": 0,
                                "total_time_spent": 0,
                                "human_time_estimate": null,
                                "human_total_time_spent": null
                            }
                        }
                        """

    func testIssueParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                let container = try decoder.singleValueContainer()
                let dateStr = try container.decode(String.self)
                let formatter = DateFormatter()
                formatter.calendar = Calendar(identifier: .iso8601)
                formatter.locale = Locale(identifier: "en_US_POSIX")
                formatter.timeZone = TimeZone(secondsFromGMT: 0)
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
                if let date = formatter.date(from: dateStr) {
                    return date
                }
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                if let date = formatter.date(from: dateStr) {
                    return date
                }

                formatter.dateFormat = "yyyy-MM-dd"
                if let date = formatter.date(from: dateStr) {
                    return date
                }
                fatalError("To be fixed")
            })

            let body = HTTPBody(string: issueString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let futureInvoice = try decoder.decode(Issue.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())

            futureInvoice.do { (issue) in
                XCTAssertEqual(issue.id, 76)
            }.catch { (error) in
                XCTFail("\(error)")
            }
        } catch {
            XCTFail("\(error)")
        }
    }

    static var allTests = [
        ("testIssueParsedProperly", testIssueParsedProperly),
    ]
}