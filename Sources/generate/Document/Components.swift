import OpenAPIKit
import Foundation

let components: OpenAPI.Components = {
    let schemas: OpenAPI.ComponentDictionary<JSONSchema> = [
        "releases": .object(
            properties: [
                "releases": .object
            ],
            example: try! .decoding(json:
                     #"""
                     {
                         "releases": {
                             "1.1.0": "https://swift.pkg.github.com/mona/LinkedList/1.1.0"
                         }
                     }
                     """#)
        ),
        "identifiers": .object(
            properties: [
                "identifiers": .array
            ],
            example: try! .decoding(json:
                     #"""
                     {
                         "identifiers": [
                           "mona.LinkedList"
                         ]
                     }
                     """#)
        ),
        "problem": .object(
            externalDocs: .init(url: URL(string: "https://tools.ietf.org/html/rfc7807")!),
            properties: [
            "type": .string(format: .extended(.uriReference)),
                "title": .string,
                "status": .number,
                "detail": .string,
                "instance": .string
            ],
            example: try! .decoding(json:
                     #"""
                     {
                         "type": "https://example.com/probs/out-of-credit",
                         "title": "You do not have enough credit.",
                         "detail": "Your current balance is 30, but that costs 50.",
                         "instance": "/account/12345/msgs/abc",
                         "balance": 30,
                         "accounts": ["/account/12345", "/account/67890"]
                     }
                     """#)
        )
    ]

    let responses: OpenAPI.ComponentDictionary<OpenAPI.Response> = {
        return [
            "problemDetails": .init(description: "A client error.",
                                    headers: [
                                        "Content-Version": .reference(.component(named: "contentVersion")),
                                        "Content-Language": .header(.init(schema: .string))
                                    ], content: [
                                        .problem: .init(schemaReference: .component(named: "problem"))
                                    ], vendorExtensions: [:])
        ]
    }()

    let parameters: OpenAPI.ComponentDictionary<OpenAPI.Parameter> = [
        "scope": OpenAPI.Parameter(name: "scope",
                                   context: .path,
                                   schema: .string(format: .generic,
                                                   required: true,
                                                   nullable: false,
                                                   pattern: #"\A[a-zA-Z\d](?:[a-zA-Z\d]|-(?=[a-zA-Z\d])){0,39}\z"#,
                                                   example: "mona")),
        "name": OpenAPI.Parameter(name: "name",
                                  context: .path,
                                  schema: .string(format: .generic,
                                                  required: true,
                                                  nullable: false,
                                                  pattern: #"\A\p{XID_Start}\p{XID_Continue}*\z"#,
                                                  example: "LinkedList")),
        "version": OpenAPI.Parameter(name: "version",
                                     context: .path,
                                     schema: .string(format: .generic,
                                                     required: true,
                                                     nullable: false,
                                                     externalDocs: OpenAPI.ExternalDocumentation(
                                                        description: "Semantic Version number",
                                                        url: URL(string: "https://semver.org")!
                                                     ),
                                                     pattern: #"^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?$"#,
                                                     example: "1.0.0-beta.1")),
        "swift_version": OpenAPI.Parameter(name: "swift-version",
                                           context: .query(required: false,
                                                           allowEmptyValue: false),
                                           schema: .string(format: .generic,
                                                           required: true,
                                                           nullable: false,
                                                           pattern: #"\d+(?:\.(\d+)){0,2}"#,
                                                           example: "1.2.3")),
        "url": OpenAPI.Parameter(name: "url",
                                 context: .query(required: true,
                                                 allowEmptyValue: false),
                                 schema: .string(format: .other("url"),
                                                 required: true,
                                                 nullable: false,
                                                 example: "https://github.com/mona/LinkedList"))
    ]

    let examples: OpenAPI.ComponentDictionary<OpenAPI.Example> = [
        "releases": #"""
                    {
                        "releases": {
                            "1.1.1": {
                                "url": "https://swift.pkg.github.com/mona/LinkedList/1.1.1"
                            },
                            "1.1.0": {
                                "url": "https://swift.pkg.github.com/mona/LinkedList/1.1.0",
                                "problem": {
                                    "status": 410,
                                    "title": "Gone",
                                    "detail": "this release was removed from the registry"
                                }
                            },
                            "1.0.0": {
                                "url": "https://swift.pkg.github.com/mona/LinkedList/1.0.0"
                            }
                        }
                    }
                    """#,
        "manifest": #"""
                    // swift-tools-version:5.0
                    import PackageDescription

                    let package = Package(
                        name: "LinkedList",
                        products: [
                            .library(name: "LinkedList", targets: ["LinkedList"])
                        ],
                        targets: [
                            .target(name: "LinkedList"),
                            .testTarget(name: "LinkedListTests", dependencies: ["LinkedList"]),
                        ],
                        swiftLanguageVersions: [.v4, .v5]
                    )
                    """#,
        "metadata": #"""
                    {
                        "@context": ["http://schema.org/"],
                        "@type": "SoftwareSourceCode",
                        "name": "LinkedList",
                        "description": "One thing links to another.",
                        "keywords": ["data-structure", "collection"],
                        "version": "1.1.1",
                        "codeRepository": "https://github.com/mona/LinkedList",
                        "license": "MIT",
                        "programmingLanguage": {
                            "@type": "ComputerLanguage",
                            "name": "Swift",
                            "url": "https://swift.org"
                        },
                        "author": {
                            "@type": "Person",
                            "@id": "https://github.com/mona",
                            "givenName": "Mona",
                            "middleName": "Lisa",
                            "familyName": "Octocat"
                        }
                    }
                    """#,
        "identifiers": #"""
                        {
                            "identifiers": [
                              "mona.LinkedList"
                            ]
                        }
                        """#
    ]

    let headers: OpenAPI.ComponentDictionary<OpenAPI.Header> = [
        "contentVersion": OpenAPI.Header(
            schema: .string(allowedValues: [apiInfo.version]),
            required: true
        )
    ]

    return OpenAPI.Components(
        schemas: schemas,
        responses: responses,
        parameters: parameters,
        examples: examples,
        headers: headers
    )
}()
