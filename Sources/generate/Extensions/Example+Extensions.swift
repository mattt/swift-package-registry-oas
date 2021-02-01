import OpenAPIKit

extension OpenAPI.Example: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        do {
            try self.init(value: .init(.decoding(json: value)))
        } catch {
            self.init(value: .init(.init(value)))
        }
    }
}
