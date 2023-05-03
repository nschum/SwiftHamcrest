import Hamcrest
import XCTest

class ArithmeticMatcherTests: BaseTestCase {
    func testEqualTo() {
        assertMatch(5, equalTo(5))
        assertMismatch(5, equalTo(10), "equal to 10")
    }

    func testCloseToFloat() {
        assertMatch(Float(5.001), closeTo(Float(5), 0.0011))
        assertMismatch(Float(5.001), closeTo(Float(5), 0.0009), "within 0.0009 of 5.0",
            mismatchDescription: "difference of 0.0009999275207519531")
    }

    func testCloseToDouble() {
        assertMatch(5.001, closeTo(5, 0.0011))
        assertMismatch(5.001, closeTo(5, 0.00091), "within 0.00091 of 5.0",
            mismatchDescription: "difference of 0.001000000000000334")
    }

    func testGreaterThan() {
        assertMatch(5.001, greaterThan(5))
        assertMismatch(5.0, greaterThan(5), "greater than 5.0")
        assertMismatch(4.999, greaterThan(5), "greater than 5.0")
    }

    func testGreaterThanOrEqualTo() {
        assertMatch(5.001, greaterThanOrEqualTo(5))
        assertMatch(5.0, greaterThanOrEqualTo(5))
        assertMismatch(4.999, greaterThanOrEqualTo(5), "greater than or equal to 5.0")
    }

    func testLessThan() {
        assertMatch(4.999, lessThan(5))
        assertMismatch(5.0, lessThan(5), "less than 5.0")
        assertMismatch(5.001, lessThan(5), "less than 5.0")
    }

    func testLessThanOrEqualTo() {
        assertMatch(4.999, lessThanOrEqualTo(5))
        assertMatch(5.0, lessThanOrEqualTo(5))
        assertMismatch(5.001, lessThanOrEqualTo(5), "less than or equal to 5.0")
    }

    func testInInterval() {
        assertMatch(5.0, inInterval(1.0...5.0))
        assertMismatch(5.0, inInterval(1.0..<5.0), "in interval 1.0..<5.0")
    }
}
