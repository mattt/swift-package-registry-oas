import OpenAPIKit
import Foundation

let apiInfo: OpenAPI.Document.Info = {
    let title: String = "Swift Package Registry"

    let version: String = "1"

    return OpenAPI.Document.Info(
        title: title,
        version: version
    )
}()
