# Swift Package Registry - OpenAPI Specification

This project generates an [OpenAPI (v3) Specification](https://swagger.io/specification/)
describing the endpoints of the proposed
[Swift package registry interface](https://github.com/apple/swift-evolution/blob/main/proposals/0292-package-registry-service.md)
It uses [OpenAPIKit](https://github.com/mattpolzin/OpenAPIKit)
to construct and verify the specification in Swift.

Rendered documentation from the latest build of the specification
can be found [here](https://mattt.github.io/swift-package-registry-oas/).

## Requirements

- Swift 5.3+
- Node v14+
- npm

## Usage

Build and run the `generate` executable to print the specification to `stdout`.

```terminal
$ swift run generate
```

Run the following commands to generate a static HTML reference
in the `dist` directory.

```terminal
$ npm install
$ npx gulp
```
