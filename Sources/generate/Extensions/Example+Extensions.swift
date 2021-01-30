import OpenAPIKit

extension OpenAPI.Example: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        do {
            try self.init(value: .init(AnyCodable.json(literal: value)))
        } catch {
            self.init(value: .init(AnyCodable(value)))
        }
    }
}
