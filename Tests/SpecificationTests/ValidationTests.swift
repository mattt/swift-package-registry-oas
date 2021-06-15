import XCTest
import Specification

final class ValidationTests: XCTestCase {
    func testValidation() throws {
        XCTAssertNoThrow {
            let url = URL(string: "https://example.com")!
            let document = specification(for: url)
            try document.validate()
        }
    }
}
