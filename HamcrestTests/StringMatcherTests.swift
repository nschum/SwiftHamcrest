import XCTest
import Hamcrest

class StringTests: BaseTestCase {

    let string = "foobar"

    func testEmpty() {
        assertMatch("", empty())

        assertMismatch(string, empty(), "empty", mismatchDescription: "count 6")
    }

    func testContainsString() {
        assertMatch(string, containsString("foo"))
        assertMatch(string, containsString("bar"))
        assertMatch(string, containsString("oob"))

        assertMismatch(string, containsString("42"), "contains \"42\"")
    }

    func testContainsStringsInOrder() {
        assertMatch(string, containsStringsInOrder("foo"))
        assertMatch(string, containsStringsInOrder("bar"))
        assertMatch(string, containsStringsInOrder("oob"))
        assertMatch(string, containsStringsInOrder("foo", "bar"))
        assertMatch(string, containsStringsInOrder("o", "a"))

        assertMismatch(string, containsStringsInOrder("42"), "contains in order \"42\"")
        assertMismatch(string, containsStringsInOrder("foob", "bar"),
            "contains in order [\"foob\", \"bar\"]")
    }

    func testHasPrefix() {
        assertMatch(string, hasPrefix("foo"))

        assertMismatch(string, hasPrefix("bar"), "has prefix \"bar\"")
    }

    func testHasSuffix() {
        assertMatch(string, hasSuffix("bar"))

        assertMismatch(string, hasSuffix("foo"), "has suffix \"foo\"")
    }
}