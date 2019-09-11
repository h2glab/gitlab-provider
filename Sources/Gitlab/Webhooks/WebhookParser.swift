import Foundation

public class WebhookParser {

    public static func parse(data: Data) throws -> WebhookResponse {
        let webhookLight = try JSONDecoder().decode(Webhook.Common.self, from: data)
        switch (webhookLight.object_kind) {
        case "issue":
            return try JSONDecoder().decode(Webhook.Issue.self, from: data)
        default:
            throw WebhookError.unsupported_data(kind: webhookLight.object_kind)
        }
    }
}
