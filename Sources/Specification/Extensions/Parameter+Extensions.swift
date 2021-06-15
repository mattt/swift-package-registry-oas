import OpenAPIKit

extension OpenAPI.Parameter {
    static func contentType(required: Bool = false, allowedValues: [OpenAPI.ContentType]) -> OpenAPI.Parameter {
        return .init(
            name: "Content-Type",
            context: .header(required: required),
            schema: .string(
                allowedValues: allowedValues.map { .init($0.rawValue) }
            )
        )
    }
}
