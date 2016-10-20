import XCTest
import Hamcrest

private class ReflectableClass {
    var property1: String = "value1"
    var property2: String = "value2"
    var property3: String = "value3"
}

class ReflectionMatcherTests: BaseTestCase {

    fileprivate let instance = ReflectableClass()

    func testHasProperty() {
        assertMatch(ReflectableClass(), hasProperty("property2", "value2"))

        assertMismatch(ReflectableClass(), hasProperty("property2", "wrong"),
            "has property \"property2\" with value \"wrong\"",
            mismatchDescription: "property value \"value2\"")
        assertMismatch(ReflectableClass(), hasProperty("wrong", "value2"),
            "has property \"wrong\" with value \"value2\"",
            mismatchDescription: "missing property")
        assertMismatch(ReflectableClass(), hasProperty("property2", 25),
            "has property \"property2\" with value 25",
            mismatchDescription: "incompatible property type")
    }

    func testHasPropertyWithMatcher() {
        assertMatch(ReflectableClass(), hasProperty("property2", equalTo("value2")))

        assertMismatch(ReflectableClass(), hasProperty("property2", equalTo("wrong")),
            "has property \"property2\" with value equal to wrong",
            mismatchDescription: "property value \"value2\"")
        assertMismatch(ReflectableClass(), hasProperty("wrong", equalTo("value2")),
            "has property \"wrong\" with value equal to value2",
            mismatchDescription: "missing property")
        assertMismatch(ReflectableClass(), hasProperty("property2", equalTo(25)),
            "has property \"property2\" with value equal to 25",
            mismatchDescription: "incompatible property type")
    }

    func testHasPropertyWithMatchers() {
        assertMatch(ReflectableClass(), hasProperty(equalTo("property2"), equalTo("value2")))

        assertMismatch(ReflectableClass(), hasProperty(equalTo("property2"), equalTo("wrong")),
            "has property equal to property2 with value equal to wrong",
            mismatchDescription: "property value \"value2\"")
        assertMismatch(ReflectableClass(), hasProperty(equalTo("wrong"), equalTo("value2")),
            "has property equal to wrong with value equal to value2",
            mismatchDescription: "missing property")
        assertMismatch(ReflectableClass(), hasProperty(equalTo("property2"), equalTo(25)),
            "has property equal to property2 with value equal to 25",
            mismatchDescription: "incompatible property type")
    }
}
