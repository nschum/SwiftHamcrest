import Hamcrest
import XCTest

class SequenceMatcherTests: BaseTestCase {

    let sequence = ["item1", "item2", "item3"]

    func testEmpty() {
        assertMatch([] as [Int], empty())
        assertMismatch(sequence, empty(), "empty", mismatchDescription: "count 3")
    }

    func testHasCount() {
        assertMatch(sequence, hasCount(3))

        assertMismatch(sequence, hasCount(2), "has count 2", mismatchDescription: "count 3")
    }

    func testHasCountWithMatcher() {
        assertMatch(sequence, hasCount(equalTo(3)))

        assertMismatch(sequence, hasCount(equalTo(2)), "has count equal to 2",
            mismatchDescription: "count 3")
    }

    func testEveryItem() {
        assertMatch(sequence, everyItem(succeedingMatcher()))

        assertMismatch(sequence, everyItem(failingMatcher()),
            "a sequence where every item description",
            mismatchDescription: "[mismatch: item1, mismatch: item2, mismatch: item3]")

        assertMismatch(sequence, everyItem(failingMatcherWithMismatchDescription()),
            "a sequence where every item description",
            mismatchDescription: "[mismatch: item1 (mismatch description), "
                + "mismatch: item2 (mismatch description), "
                + "mismatch: item3 (mismatch description)]")
    }

    func testHasItem() {
        assertMatch(sequence, hasItem("item2"))

        assertMismatch(sequence, hasItem("wrong"), "a sequence containing \"wrong\"")
    }

    func testHasItemWithMatcher() {
        assertMatch(sequence, hasItem(equalTo("item2")))

        assertMismatch(sequence, hasItem(equalTo("wrong")), "a sequence containing equal to wrong")
    }

    func testHasItems() {
        assertMatch(sequence, hasItems("item2"))
        assertMatch(sequence, hasItems("item2", "item3"))

        assertMismatch(sequence, hasItems("wrong"), "a sequence containing \"wrong\"",
            mismatchDescription: "missing item \"wrong\"")
        assertMismatch(sequence, hasItems("item2", "wrong"),
            "a sequence containing all of [\"item2\", \"wrong\"]",
            mismatchDescription: "missing item \"wrong\"")
        assertMismatch(sequence, hasItems("wrong1", "wrong2"),
            "a sequence containing all of [\"wrong1\", \"wrong2\"]",
            mismatchDescription: "missing items [\"wrong1\", \"wrong2\"]")
    }

    func testHasItemsWithMatcher() {
        assertMatch(sequence, hasItems(equalTo("item2")))
        assertMatch(sequence, hasItems(equalTo("item2"), equalTo("item3")))

        assertMismatch(sequence, hasItems(equalTo("wrong")), "a sequence containing equal to wrong",
            mismatchDescription: "missing item equal to wrong")
        assertMismatch(sequence, hasItems(equalTo("item2"), equalTo("wrong")),
            "a sequence containing all of [equal to item2, equal to wrong]",
            mismatchDescription: "missing item equal to wrong")
        assertMismatch(sequence, hasItems(equalTo("wrong1"), equalTo("wrong2")),
            "a sequence containing all of [equal to wrong1, equal to wrong2]",
            mismatchDescription: "missing items [equal to wrong1, equal to wrong2]")
    }

    func testContains() {
        assertMatch(sequence, contains("item1", "item2", "item3"))

        assertMismatch(sequence, contains("item1", "item2"),
            "a sequence containing [\"item1\", \"item2\"]",
            mismatchDescription: "unmatched item \"item3\"")
        assertMismatch(sequence, contains("item1", "item2", "item3", "item4"),
            "a sequence containing [\"item1\", \"item2\", \"item3\", \"item4\"]",
            mismatchDescription: "missing item \"item4\"")
        assertMismatch(sequence, contains("item1", "wrong", "item3"),
            "a sequence containing [\"item1\", \"wrong\", \"item3\"]",
            mismatchDescription: "mismatch: GOT: \"item2\", EXPECTED: \"wrong\"")
    }

    func testContainsWithMatcher() {
        assertMatch(sequence, contains(equalTo("item1"), equalTo("item2"), equalTo("item3")))

        assertMismatch(sequence, contains(equalTo("item1"), equalTo("item2")),
            "a sequence containing [equal to item1, equal to item2]",
            mismatchDescription: "unmatched item \"item3\"")
        assertMismatch(sequence,
            contains(equalTo("item1"), equalTo("item2"), equalTo("item3"), equalTo("item4")),
            "a sequence containing "
                + "[equal to item1, equal to item2, equal to item3, equal to item4]",
            mismatchDescription: "missing item equal to item4")
        assertMismatch(sequence, contains(equalTo("item1"), equalTo("wrong"), equalTo("item3")),
            "a sequence containing [equal to item1, equal to wrong, equal to item3]",
            mismatchDescription: "mismatch: GOT: \"item2\", EXPECTED: equal to wrong")
    }

    func testContainsInAnyOrder() {
        assertMatch(sequence, containsInAnyOrder("item1", "item2", "item3"))
        assertMatch(sequence, containsInAnyOrder("item1", "item3", "item2"))
        assertMatch(sequence, containsInAnyOrder("item3", "item1", "item2"))

        assertMismatch(sequence, containsInAnyOrder("item2", "item1"),
            "a sequence containing in any order [\"item2\", \"item1\"]",
            mismatchDescription: "unmatched item \"item3\"")
        assertMismatch(sequence, containsInAnyOrder("item4", "item3", "item2", "item1"),
            "a sequence containing in any order [\"item4\", \"item3\", \"item2\", \"item1\"]",
            mismatchDescription: "missing item \"item4\"")
        assertMismatch(sequence, containsInAnyOrder("item3", "wrong", "item1"),
            "a sequence containing in any order [\"item3\", \"wrong\", \"item1\"]",
            mismatchDescription: "mismatch: GOT: \"item2\", EXPECTED: \"wrong\"")
    }

    func testContainsInAnyOrderWithMatcher() {
        assertMatch(sequence,
            containsInAnyOrder(equalTo("item1"), equalTo("item2"), equalTo("item3")))
        assertMatch(sequence,
            containsInAnyOrder(equalTo("item1"), equalTo("item3"), equalTo("item2")))
        assertMatch(sequence,
            containsInAnyOrder(equalTo("item3"), equalTo("item1"), equalTo("item2")))

        assertMismatch(sequence, containsInAnyOrder(equalTo("item2"), equalTo("item1")),
            "a sequence containing in any order [equal to item2, equal to item1]",
            mismatchDescription: "unmatched item \"item3\"")
        assertMismatch(sequence, containsInAnyOrder(
            equalTo("item4"), equalTo("item3"), equalTo("item2"), equalTo("item1")),
            "a sequence containing in any order "
                + "[equal to item4, equal to item3, equal to item2, equal to item1]",
            mismatchDescription: "missing item equal to item4")
        assertMismatch(sequence,
            containsInAnyOrder(equalTo("item3"), equalTo("wrong"), equalTo("item1")),
            "a sequence containing in any order [equal to item3, equal to wrong, equal to item1]",
            mismatchDescription: "mismatch: GOT: \"item2\", EXPECTED: equal to wrong")
    }
}
