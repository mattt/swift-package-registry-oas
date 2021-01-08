import OpenAPIKit

extension OpenAPI.ContentType {
    static func vnd_swift_registry(_ suffix: String? = nil) -> OpenAPI.ContentType {
        var type = "application/vnd.swift.registry.v1"
        if let suffix = suffix {
            type += "+\(suffix)"
        }

        return .other(type)
    }

    static let swift = OpenAPI.ContentType(rawValue: "text/x-swift")!
    static let zip = OpenAPI.ContentType(rawValue: "application/zip")!
    static let problem = OpenAPI.ContentType(rawValue: "application/problem+json")!
}
