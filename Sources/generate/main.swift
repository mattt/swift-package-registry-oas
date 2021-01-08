import OpenAPIKit
import Foundation
import Yams

let url = URL(string: "https://example.com")!

let document = specification(for: url)
try document.validate()

let encoder = YAMLEncoder()
let yaml = try encoder.encode(document)

print(yaml)
