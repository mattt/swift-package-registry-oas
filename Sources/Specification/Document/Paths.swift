import OpenAPIKit
import Foundation

var paths: OpenAPI.PathItem.Map = [
    "/{scope}/{name}": .init(
        parameters: [
            .reference(.component(named: "scope")),
            .reference(.component(named: "name"))
        ],
        get: .init(
            tags: ["Package"],
            summary: "List package releases",
            operationId: "listPackageReleases",
            parameters: [
                .parameter(.contentType(allowedValues: [.vnd_swift_registry("json")]))
            ],
            responses: [
                200: .response(
                    description: "",
                    headers: [
                        "Content-Version": .reference(.component(named: "contentVersion")),
                        "Content-Length": .header(.init(schema: .integer))
                    ],
                    content: [
                        .json: .init(schema: .reference(.component(named: "releases")),
                                     examples: [
                                        "default": .reference(.component(named: "releases"))
                                     ])
                    ]
                ),
                .range(.clientError): .reference(.component(named: "problemDetails"))
            ]
        )
    ),

    "/{scope}/{name}/{version}": .init(
        parameters: [
            .reference(.component(named: "scope")),
            .reference(.component(named: "name")),
            .reference(.component(named: "version"))
        ],
        get: .init(
            tags: ["Release"],
            summary: "Fetch release metadata",
            operationId: "fetchReleaseMetadata",
            parameters: [
                .parameter(.contentType(allowedValues: [.vnd_swift_registry("json")]))
            ],
            responses: [
                200: .response(
                    description: "",
                    headers: [
                        "Content-Version": .reference(.component(named: "contentVersion")),
                        "Content-Length": .header(.init(schema: .integer))
                    ],
                    content: [
                        .json: .init(schema: .object,
                                     examples: [
                                        "default": .reference(.component(named: "metadata"))
                                     ])
                    ]
                ),
                .range(.clientError): .reference(.component(named: "problemDetails"))
            ]
        )
    ),

    "/{scope}/{name}/{version}/Package.swift": .init(
        parameters: [
            .reference(.component(named: "scope")),
            .reference(.component(named: "name")),
            .reference(.component(named: "version"))
        ],
        get: .init(
            tags: ["Release"],
            summary: "Fetch manifest for a package release",
            operationId: "fetchManifestForPackageRelease",
            parameters: [
                .parameter(.contentType(allowedValues: [.vnd_swift_registry("swift")])),
                .reference(.component(named: "swift_version"))
            ],
            responses: [
                200: .response(
                    description: "",
                    headers: [
                        "Cache-Control": .header(.init(schema: .string)),
                        "Content-Disposition": .header(.init(schema: .string)),
                        "Content-Length": .header(.init(schema: .integer)),
                        "Content-Version": .reference(.component(named: "contentVersion")),
                        "Link": .header(.init(schema: .string)),
                    ],
                    content: [
                        .swift: .init(schema: .string(format: .generic,
                                                      required: true,
                                                      nullable: false),
                                      examples: [
                                        "default": .reference(.component(named: "manifest"))
                                      ])
                    ]
                ),
                .range(.clientError): .reference(.component(named: "problemDetails"))
            ]
        )
    ),

    "/{scope}/{name}/{version}.zip": .init(
        parameters: [
            .reference(.component(named: "scope")),
            .reference(.component(named: "name")),
            .reference(.component(named: "version"))
        ],
        get: .init(
            tags: ["Release"],
            summary: "Download source archive",
            operationId: "downloadSourceArchive",
            parameters: [
                .parameter(.contentType(allowedValues: [.vnd_swift_registry("zip")]))
            ],
            responses: [
                200: .response(
                    description: "",
                    headers: [
                        "Accept-Ranges": .header(.init(schema: .string)),
                        "Cache-Control": .header(.init(schema: .string)),
                        "Content-Disposition": .header(.init(schema: .string)),
                        "Content-Length": .header(.init(schema: .integer)),
                        "Content-Version": .reference(.component(named: "contentVersion")),
                        "Digest": .header(.init(schema: .string, required: true)),
                        "Link": .header(.init(schema: .string)),
                    ],
                    content: [
                        .zip: .init(schema: .string(format: .binary,
                                                    required: true,
                                                    nullable: false))
                    ]
                ),
                .range(.redirect): .reference(.component(named: "redirect")),
                .range(.clientError): .reference(.component(named: "problemDetails"))
            ]
        )
    ),

    "/identifiers": .init(
        parameters: [
            .reference(.component(named: "url")),
        ],
        get: .init(
            tags: ["Package"],
            summary: "Lookup package identifiers registered for a URL",
            operationId: "lookupPackageIdentifiersByURL",
            parameters: [
                .parameter(.contentType(allowedValues: [.vnd_swift_registry("json")]))
            ],
            responses: [
                200: .response(
                    description: "",
                    headers: [
                        "Content-Version": .reference(.component(named: "contentVersion"))
                    ],
                    content: [
                        .json: .init(schema: .reference(.component(named: "identifiers")),
                                     examples: [
                                        "default": .reference(.component(named: "identifiers"))
                                     ])
                    ]
                ),
                .range(.clientError): .reference(.component(named: "problemDetails"))
            ]
        )
    ),

    "/{scope}/{name}/{version}": .init(
        parameters: [
            .reference(.component(named: "scope")),
            .reference(.component(named: "name")),
            .reference(.component(named: "version"))
        ],
        post: .init(
            tags: ["Package"],
            summary: "Publish package release",
            operationId: "publishPackageRelease",
            parameters: [
                .parameter(.contentType(allowedValues: [.vnd_swift_registry("json")]))
            ],
            responses: [
                100: .response(description: ""),
                201: .response(
                    description: "",
                    headers: [
                        "Content-Version": .reference(.component(named: "contentVersion")),
                        "Content-Length": .header(.init(schema: .integer))
                    ],
                    content: [
                        .json: .init(schema: .reference(.component(named: "releases")),
                                     examples: [
                                        "default": .reference(.component(named: "releases"))
                                     ])
                    ]
                ),
                202: .response(
                    description: "",
                    headers: [
                        "Content-Version": .reference(.component(named: "contentVersion")),
                        "Location": .header(.init(schema: .string)),
                        "Retry-After": .header(.init(schema: .integer))
                    ]
                ),
                .range(.clientError): .reference(.component(named: "problemDetails"))
            ]
        )
    )
]

