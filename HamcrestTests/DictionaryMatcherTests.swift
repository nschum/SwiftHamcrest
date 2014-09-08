import XCTest
import Hamcrest

class DictionaryMatcherTests: BaseTestCase {

    let dictionary = [
        "key1": "value1",
        "key2": "value2",
        "key3": "value3",
    ]

    func testHasEntry() {
        assertMatch(dictionary, hasEntry("key2", "value2"))

        assertMismatch(dictionary, hasEntry("key2", "wrong"),
            "a dictionary containing [\"key2\" -> \"wrong\"]")
        assertMismatch(dictionary, hasEntry("wrong", "value2"),
            "a dictionary containing [\"wrong\" -> \"value2\"]")
    }

    func testHasKey() {
        assertMatch(dictionary, hasKey("key1"))

        assertMismatch(dictionary, hasKey("wrong"),
            "a dictionary containing [\"wrong\" -> anything]")
    }

    func testHasValue() {
        assertMatch(dictionary, hasValue("value1"))

        assertMismatch(dictionary, hasValue("wrong"),
            "a dictionary containing [anything -> \"wrong\"]")
    }
}
