import OpenAPIKit
import Foundation

let externalDocs: OpenAPI.ExternalDocumentation = {
    let description: String = "Swift Evolution Proposal SE-0292"
    let url: URL = URL(string: "https://github.com/apple/swift-evolution/blob/main/proposals/0292-package-registry-service.md")!

    return OpenAPI.ExternalDocumentation(
        description: description,
        url: url
    )
}()
