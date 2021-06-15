import OpenAPIKit
import class Foundation.JSONDecoder

extension AnyCodable {
    static func decoding(json string: String, with decoder: JSONDecoder = .init()) throws -> AnyCodable {
        guard let data = string.data(using: .utf8) else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "invalid UTF-8 data")
            throw DecodingError.dataCorrupted(context)
        }

        return try decoder.decode(AnyCodable.self, from: data)
    }
}
