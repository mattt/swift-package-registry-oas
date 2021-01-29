import OpenAPIKit
import Foundation
import Yams

let url = URL(string: "https://packages.swift.org")!

let document = specification(for: url)
try document.validate()

let encoder = YAMLEncoder()
let yaml = try encoder.encode(document)

print(yaml)
