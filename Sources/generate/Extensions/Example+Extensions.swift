import OpenAPIKit

extension OpenAPI.Example: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value: .init(AnyCodable(value)))
    }
}
