import OpenAPIKit
import struct Foundation.URL

public func specification(for url: URL) -> OpenAPI.Document {
    return .init(
        openAPIVersion: .v3_0_0,
        info: apiInfo,
        servers: [OpenAPI.Server(url: url)],
        paths: paths,
        components: components,
        externalDocs: externalDocs
    )
}
