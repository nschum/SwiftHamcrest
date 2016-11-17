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

class BasicMatcherTests: BaseTestCase {

    func testAnything() {
        assertMatch(5, anything())
    }

    func testIs() {
        assertMatch(5, `is`(5))
        assertMismatch(5, `is`(10), "is equal to 10")
    }

    func testIsA() {
        assertMatch(5, isA(Int.self))
        assertMismatch(5, isA(String.self), "is instance of String")
    }

    func testNot() {
        assertMatch(5, not(10))
        assertMismatch(5, not(5), "not 5")
    }

    func testSameInstance() {
        assertMatch(self, sameInstance(self))

        let o1 = SampleClass()
        let o2 = SampleClass()
        assertMismatch(o1, sameInstance(o2),
            "same instance as \(address(o2))", mismatchDescription:address(o1))
    }

    func testInstanceOf() {
        assertMatch(5, instanceOf(Int.self))
        assertMismatch(5, instanceOf(String.self), "instance of String")
    }

    func testNilValue() {
        assertMatch(nil as Int?, nilValue())
        assertMismatch(Optional(5), nilValue(), "nil")
    }

    func testPresent() {
        assertMatch(Optional(5), present())
        assertMismatch(nil as Int?, present(), "present")
    }
}
