import Hamcrest
import XCTest

class MetaMatcherTests: BaseTestCase {
    func testIs() {
        assertMatch(5, `is`(succeedingMatcher()))
        assertMismatch(5, `is`(failingMatcher()), "is description")
        assertMismatch(5, `is`(failingMatcher()), "is description")
        assertMismatch(5, `is`(failingMatcherWithMismatchDescription()), "is description",
            mismatchDescription: "mismatch description")
    }

    func testInstanceOfAnd() {
        assertMatch(5, instanceOf(Int.self, and: succeedingMatcher()))

        assertMismatch(5, instanceOf(Int.self, and: failingMatcher()),
            "instance of Int and description")
        assertMismatch(5, instanceOf(Double.self, and: failingMatcher()),
            "instance of Double and description", mismatchDescription: "mismatched type")

        assertMismatch(5, instanceOf(Int.self, and: failingMatcherWithMismatchDescription()),
            "instance of Int and description", mismatchDescription: "mismatch description")
        assertMismatch(5, instanceOf(Double.self, and: failingMatcherWithMismatchDescription()),
            "instance of Double and description", mismatchDescription: "mismatched type")

        assertMatch(5, instanceOfAnd(succeedingMatcher(Int.self)))
        assertMismatch(5, instanceOfAnd(failingMatcher(Int.self)),
            "instance of Int and description")
        assertMismatch(5, instanceOfAnd(failingMatcher(Double.self)),
            "instance of Double and description", mismatchDescription: "mismatched type")
    }

    func testPresentAnd() {
        assertMatch(Optional(5), presentAnd(succeedingMatcher()))

        assertMismatch(Optional(5), presentAnd(failingMatcher()), "present and description")
        assertMismatch(nil as Int?, presentAnd(failingMatcher()), "present and description")

        assertMismatch(Optional(5), presentAnd(failingMatcherWithMismatchDescription()),
            "present and description", mismatchDescription: "mismatch description")
        assertMismatch(nil as Int?, presentAnd(failingMatcherWithMismatchDescription()),
            "present and description")
    }

    func testNot() {
        assertMatch(5, not(failingMatcher()))
        assertMatch(5, not(failingMatcherWithMismatchDescription()))

        assertMismatch(5, not(succeedingMatcher()), "not description")
    }

    func testAllOf() {
        assertMatch(5, allOf(succeedingMatcher()))
        assertMatch(5, allOf(succeedingMatcher(), succeedingMatcher()))

        assertMismatch(5, allOf(failingMatcher()), "description",
            mismatchDescription: "mismatch: description")
        assertMismatch(5,
            allOf(succeedingMatcher(description: "d1"), failingMatcher(description: "d2")),
            "all of [d1, d2]",
            mismatchDescription: "mismatch: d2")

        assertMismatch(5,
            allOf(
                failingMatcherWithMismatchDescription(description: "d1"),
                failingMatcher(description: "d2")
            ),
            "all of [d1, d2]",
            mismatchDescription: "[mismatch: d1 (mismatch description), mismatch: d2]")
    }

    func testAllOfSequence() {
        assertMatch(5, allOf([succeedingMatcher()]))
        assertMatch(5, allOf([succeedingMatcher(), succeedingMatcher()]))

        assertMismatch(5, allOf([failingMatcher()]), "description",
            mismatchDescription: "mismatch: description")
        assertMismatch(5,
            allOf([succeedingMatcher(description: "d1"), failingMatcher(description: "d2")]),
            "all of [d1, d2]",
            mismatchDescription: "mismatch: d2")

        assertMismatch(5,
            allOf([
                failingMatcherWithMismatchDescription(description: "d1"),
                failingMatcher(description: "d2")
            ]),
            "all of [d1, d2]",
            mismatchDescription: "[mismatch: d1 (mismatch description), mismatch: d2]")
    }

    func testAllOfOperator() {
        assertMatch(5, succeedingMatcher() && succeedingMatcher())

        assertMismatch(5, succeedingMatcher(description: "d1") && failingMatcher(description: "d2"),
            "all of [d1, d2]",
            mismatchDescription: "mismatch: d2")

        assertMismatch(5,
            failingMatcherWithMismatchDescription(description: "d1")
                && failingMatcher(description: "d2"),
            "all of [d1, d2]",
            mismatchDescription: "[mismatch: d1 (mismatch description), mismatch: d2]")
    }

    func testAnyOf() {
        assertMatch(5, anyOf(succeedingMatcher()))
        assertMatch(5, anyOf(succeedingMatcher(), succeedingMatcher()))
        assertMatch(5, anyOf(succeedingMatcher(), failingMatcher()))

        assertMismatch(5, anyOf(failingMatcher()), "description")
        assertMismatch(5,
            anyOf(failingMatcher(description: "d1"), failingMatcher(description: "d2")),
            "any of [d1, d2]")
    }

    func testAnyOfSequence() {
        assertMatch(5, anyOf([succeedingMatcher()]))
        assertMatch(5, anyOf([succeedingMatcher(), succeedingMatcher()]))
        assertMatch(5, anyOf([succeedingMatcher(), failingMatcher()]))

        assertMismatch(5, anyOf([failingMatcher()]), "description")
        assertMismatch(5,
            anyOf([failingMatcher(description: "d1"), failingMatcher(description: "d2")]),
            "any of [d1, d2]")
    }

    func testAnyOfOperator() {
        assertMatch(5, succeedingMatcher() || succeedingMatcher())
        assertMatch(5, succeedingMatcher() || failingMatcher())

        assertMismatch(5,
            failingMatcher(description: "d1") || failingMatcher(description: "d2"),
            "any of [d1, d2]")
    }

    func testDescribedAs() {
        assertMatch(5, describedAs("foo", succeedingMatcher()))

        assertMismatch(5, describedAs("foo", failingMatcher()), "foo")
        assertMismatch(5, describedAs("foo", failingMatcherWithMismatchDescription()), "foo",
            mismatchDescription: "mismatch description")
    }
}
