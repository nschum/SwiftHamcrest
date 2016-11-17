import XCTest
import Hamcrest

private class SampleClass: CustomStringConvertible {
    var description: String {
        return "SampleClass instance"
    }
}

private func address<T: AnyObject>(_ object: T) -> String {
    return NSString(format: "%p", unsafeBitCast(object, to: Int.self)) as String
}

class OperatorMatcherTests: BaseTestCase {

    func testSameInstance() {
        let object = SampleClass()
        assertThat(object === object)

        assertReportsNoError()
    }

    func testSameInstanceMismatch() {
        let o1 = SampleClass()
        let o2 = SampleClass()
        assertThat(o1 === o2)

        assertReportsMismatch(o1, "same instance as \(address(o2))", mismatchDescription:address(o1))
    }

    func testEquals() {
        assertThat(0 == 0)

        assertReportsNoError()
    }

    func testEqualsMismatch() {
        assertThat(0 == 42)

        assertReportsMismatch(0, "equal to 42")
    }

    func testGreaterThan() {
        assertThat(1 > 0)

        assertReportsNoError()
    }

    func testGreaterThanMismatch() {
        assertThat(0 > 1)

        assertReportsMismatch(0, "greater than 1")
    }

    func testGreaterThanOrEqual() {
        assertThat(1 >= 0)

        assertReportsNoError()
    }

    func testGreaterThanOrEqualMismatch() {
        assertThat(0 >= 1)

        assertReportsMismatch(0, "greater than or equal to 1")
    }

    func testLessThan() {
        assertThat(0 < 1)

        assertReportsNoError()
    }

    func testLessThanMismatch() {
        assertThat(1 < 0)

        assertReportsMismatch(1, "less than 0")
    }

    func testLessThanOrEqual() {
        assertThat(0 <= 1)

        assertReportsNoError()
    }

    func testLessThanOrEqualMismatch() {
        assertThat(1 <= 0)

        assertReportsMismatch(1, "less than or equal to 0")
    }

    func testTrueAndTrue() {
        assertThat(0 == 0 && 1 == 1)

        assertReportsNoError()
    }

    func testTrueAndFalse() {
        assertThat(0 == 0 && 0 == 1)

        assertReportsMismatch(0, "equal to 1")
    }

    func testFalseAndTrue() {
        assertThat(1 == 0 && 0 == 0)

        assertReportsMismatch(1, "equal to 0")
    }

    func testFalseAndFalse() {
        assertThat(0 == 1 && 1 == 0)

        assertReportsError("GOT: 0, EXPECTED: equal to 1 and GOT: 1, EXPECTED: equal to 0")
    }
}
