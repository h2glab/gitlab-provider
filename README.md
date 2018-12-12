# Vapor Gitlab Provider

![Swift](http://img.shields.io/badge/swift-4.1-brightgreen.svg)
![Vapor](http://img.shields.io/badge/vapor-3.0-brightgreen.svg)

## Getting Started
In your `Package.swift` file, add the following

```swift
.package(url: "https://github.com/h2glab/gitlab-provider.git", from: "0.1.0")
```

Register the config and the provider to your Application

```swift
let config = GitlabConfig(serverUrl: URL(string: "https://www.gitlab.com")!, privateToken: "PRIVATE_TOKEN")

services.register(config)

try services.register(GitlabProvider())

app = try Application(services: services)

gitlabClient = try app.make(GitlabClient.self)
```

Service is configured. 

Interacting with the API is quite easy and adopts the `Future` syntax used in Vapor 3.
Now you can list all issues easily.

```swift
let filter = Issue.Filter.Builder().withLabels(["High"]).withPerPage(10).build()

let futureIssue = try gitlabClient.issue.list(filter: filter)

futureIssue.map { issues in (do something with issues...) }
```

## Whats Implemented

TBD

## License

Vapor Gitlab Provider is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## Contributing

To contribute a feature or idea to Gitlab Provider, [create an issue][1] explaining your idea.

If you find a bug, please [create an issue][1].

[1]:  https://github.com/h2glab/gitlab-provider/issues/new