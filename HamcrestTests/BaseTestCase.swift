import Hamcrest
import XCTest

class BaseTestCase: XCTestCase {

    var reportedError: String?

    override func setUp() {
        HamcrestReportFunction = {message, file, line in self.reportedError = message}
        super.setUp()
    }

    func assertMatch<T>(_ value: [T], _ matcher: Matcher<[T]>, file: StaticString = #file, line: UInt = #line) {
        reportedError = nil
        assertThat(value, matcher)
        assertReportsNoError(file, line: line)
    }

    func assertMatch<T>(_ value: T, _ matcher: Matcher<T>, file: StaticString = #file, line: UInt = #line) {
        reportedError = nil
        assertThat(value, matcher)
        assertReportsNoError(file, line: line)
    }

    func assertMismatch<T>(_ value: T, _ matcher: Matcher<T>, _ description: String,
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

    func assertMismatch<T>(_ value: [T], _ matcher: Matcher<[T]>, _ description: String,
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

    func assertReportsNoError(_ file: StaticString = #file, line: UInt = #line) {
        XCTAssertNil(reportedError, file: file, line: line)
    }

    func assertReportsError(_ message: String, file: StaticString = #file, line: UInt = #line) {
        XCTAssertNotNil(reportedError, file: file, line: line)
        XCTAssertEqual((reportedError ?? ""), message, file: file, line: line)
    }

    func assertReportsMismatch<T>(_ value: T, _ description: String, mismatchDescription: String? = nil, file: StaticString = #file, line: UInt = #line) {
        let message = expectedMessage(value, description, mismatchDescription: mismatchDescription)
        assertReportsError(message, file: file, line: line)
    }
}

private func expectedMessage(_ value: Any, _ description: String, mismatchDescription: String?)
    -> String {

    let inset = (mismatchDescription.map {" (\($0))"} ?? "")
    return "GOT: \(valueDescription(value))\(inset), EXPECTED: \(description)"
}

private func valueDescription(_ value: Any) -> String {
    if let stringArray = value as? [String] {
        return joinStrings(stringArray.map {valueDescription($0)})
    } else if let string = value as? String {
        return "\"\(string)\""
    } else {
        return String(describing: value)
    }
}

private func joinStrings(_ strings: [String]) -> String {
    switch strings.count {
    case 0:
        return "none"
    case 1:
        return strings[0]
    default:
        return "[" + strings.joined(separator: ", ") + "]"
    }
}
