import XCTest
import Specification
import Yams

final class ValidationTests: XCTestCase {
    func testValidation() throws {
        let document = specification(for: URL(string: "https://example.com")!)
        try document.validate()
    }

    func testPublishReleaseRequestBody() throws {
        let document = specification(for: URL(string: "https://example.com")!)
        let yaml = try YAMLEncoder().encode(document)
        let root = try XCTUnwrap(compose(yaml: yaml))
        let publish = try XCTUnwrap(root["paths"]?["/{scope}/{name}/{version}"]?["put"])
        XCTAssertEqual(publish["requestBody"]?["$ref"]?.string, "#/components/requestBodies/releasePayload")
        let parameters = publish["parameters"]?.sequence
        XCTAssertFalse(parameters?.contains { $0["name"]?.string == "Content-Type" } ?? false)

        let body = try XCTUnwrap(root["components"]?["requestBodies"]?["releasePayload"])
        XCTAssertEqual(body["required"]?.bool, true)
        let multipart = try XCTUnwrap(body["content"]?["multipart/form-data"])
        let schema = try XCTUnwrap(multipart["schema"])
        XCTAssertEqual(schema["required"]?.sequence?.map { $0.string }, ["source-archive"])
        let properties = schema["properties"]
        XCTAssertEqual(properties?["source-archive"]?["type"]?.string, "string")
        XCTAssertEqual(properties?["source-archive"]?["format"]?.string, "binary")
        XCTAssertEqual(properties?["metadata"]?["type"]?.string, "object")

        let encoding = multipart["encoding"]
        XCTAssertEqual(encoding?["source-archive"]?["contentType"]?.string, "application/zip")
        XCTAssertEqual(encoding?["metadata"]?["contentType"]?.string, "application/json")
    }
}
