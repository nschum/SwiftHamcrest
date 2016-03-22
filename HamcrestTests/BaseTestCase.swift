import XCTest
import Hamcrest

class BaseTestCase: XCTestCase {

    var reportedError: String? = nil

    override func setUp() {
        HamcrestReportFunction = {(message, file, line) in self.reportedError = message}
        super.setUp()
    }

    func assertMatch<T>(value: T, _ matcher: Matcher<T>,
                        file: StaticString = #file, line: UInt = #line) {

        reportedError = nil
        assertThat(value, matcher)
        assertReportsNoError(file, line: line)
    }

    func assertMismatch<T>(value: T, _ matcher: Matcher<T>, _ description: String,
                           mismatchDescription: String? = nil,
                           file: StaticString = #file, line: UInt = #line) {

        reportedError = nil
        assertThat(value, matcher)
        if let mismatchDescription = mismatchDescription {
            assertReportsMismatch(value, description, mismatchDescription: mismatchDescription, file: file, line: line)
        } else {
            assertReportsMismatch(value, description, file: file, line: line)
        }
    }

    func assertMismatch<T>(value: [T], _ matcher: Matcher<[T]>, _ description: String,
                           mismatchDescription: String? = nil,
                           file: StaticString = #file, line: UInt = #line) {

        reportedError = nil
        assertThat(value, matcher)
        if let mismatchDescription = mismatchDescription {
            assertReportsMismatch(value, description, mismatchDescription: mismatchDescription, file: file, line: line)
        } else {
            assertReportsMismatch(value, description, file: file, line: line)
        }
    }

    func assertReportsNoError(file: StaticString = #file, line: UInt = #line) {
        XCTAssertNil(reportedError, file: file, line: line)
    }

    func assertReportsError(message: String, file: StaticString = #file, line: UInt = #line) {
        XCTAssertNotNil(reportedError, file: file, line: line)
        XCTAssertEqual((reportedError ?? ""), message, file: file, line: line)
    }

    func assertReportsMismatch<T>(value: T, _ description: String, mismatchDescription: String? = nil, file: StaticString = #file, line: UInt = #line) {
        let message = expectedMessage(value, description, mismatchDescription: mismatchDescription)
        assertReportsError(message, file: file, line: line)
    }
}

private func expectedMessage(value: Any, _ description: String, mismatchDescription: String?)
    -> String {

    let inset = (mismatchDescription.map{" (\($0))"} ?? "")
    return "GOT: \(valueDescription(value))\(inset), EXPECTED: \(description)"
}

private func valueDescription(value: Any) -> String {
    if let stringArray = value as? [String] {
        return joinStrings(stringArray.map {valueDescription($0)})
    } else if let string = value as? String {
        return "\"\(string)\""
    } else {
        return String(value)
    }
}

private func joinStrings(strings: [String]) -> String {
    switch (strings.count) {
    case 0:
        return "none"
    case 1:
        return strings[0]
    default:
        return "[" + strings.joinWithSeparator(", ") + "]"
    }
}