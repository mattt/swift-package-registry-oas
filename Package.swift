// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PackageRegistryOpenAPI",
    dependencies: [
        .package(url: "https://github.com/mattpolzin/OpenAPIKit.git", from: "2.3.1"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "4.0.3"),
    ],
    targets: [
        .target(
            name: "Specification",
            dependencies: [
                .product(name: "OpenAPIKit", package: "OpenAPIKit"),
            ]),
        .target(
            name: "generate",
            dependencies: [
                .target(name: "Specification"),
                .product(name: "OpenAPIKit", package: "OpenAPIKit"),
                .product(name: "Yams", package: "Yams")
            ]),
        .testTarget(name: "SpecificationTests",
                    dependencies: ["Specification"])
    ]
)
