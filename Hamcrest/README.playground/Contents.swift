//: Swift Hamcrest
//: ==============
//:
//: Hamcrest gives you advanced matchers with better error messages for your unit tests.
//:
//: Hamcrest was originally written in Java and is available for [many languages][].
//:
//: Tutorial
//: --------
//:
//: Normally, you use these matchers in unit tests, where a mismatch will cause the test to fail, but they also work in Playgrounds, where a mismatch will simply print the error message.
//:
//: **To use this Playground, make sure to build the “Hamcrest OS X” target first (⌘B)!**
//:
//: In either case, the Hamcrest module needs to be imported.

import Hamcrest

//: ### Operator Matchers
//: The following are very simply matchers. The matched expressions look like regular boolean expressions, but provide readable mismatch messages instead of a generic error.

let x = 1 + 1

assertThat(x == 2)
assertThat(x == 3)

assertThat(x > 1)
assertThat(x > 2)

assertThat(x >= 2)
assertThat(x >= 3)

assertThat(x < 3)
assertThat(x < 2)

assertThat(x <= 2)
assertThat(x <= 1)

assertThat(x, inInterval(1...2))
assertThat(x, inInterval(1..<2))

class Test {}
let o = Test()
assertThat(o === o)
assertThat(o === Test()) // mismatch

//: ### Textual Matchers
//: All these matchers are also available as functions.

assertThat(x, equalTo(2))
assertThat(x, equalTo(3)) // mismatch

assertThat(x, greaterThan(1))
assertThat(x, greaterThan(2)) // mismatch

assertThat(x, greaterThanOrEqualTo(2))
assertThat(x, greaterThanOrEqualTo(3)) // mismatch

assertThat(x, lessThan(3))
assertThat(x, lessThan(2)) // mismatch

assertThat(x, lessThanOrEqualTo(2))
assertThat(x, lessThanOrEqualTo(1)) // mismatch

assertThat(o, sameInstance(o))
assertThat(o, sameInstance(Test())) // mismatch

//: Here are some more straightforward matchers:

assertThat("foobarbaz", containsString("bar"))
assertThat("foobarbaz", containsString("bla")) // mismatch

assertThat("foobarbaz", containsStringsInOrder("f", "b", "b"))
assertThat("foobarbaz", containsStringsInOrder("foo", "baz", "bar")) // mismatch

assertThat("foobarbaz", hasPrefix("foo"))
assertThat("foobarbaz", hasPrefix("oo")) // mismatch

assertThat("foobarbaz", hasSuffix("baz"))
assertThat("foobarbaz", hasSuffix("ba")) // mismatch

assertThat(10.0, closeTo(10.0, 0.01))
assertThat(10.0000001, closeTo(10, 0.01))
assertThat(10.1, closeTo(10, 0.01)) // mismatch

import Foundation
assertThat(CGPoint(x: 5, y: 10), hasProperty("x", closeTo(5.0, 0.00001)))
assertThat(CGPoint(x: 5, y: 10), hasProperty("y", closeTo(0.0, 0.00001))) // mismatch

//: ### Combining Matchers
//: The real power of Hamcrest comes combining multiple matchers into a single assertion statement.

assertThat(x, not(equalTo(3)))
assertThat(x, not(equalTo(2))) // mismatch

assertThat(x, allOf(greaterThan(1), lessThan(3)))
assertThat(x, allOf(greaterThan(2), lessThan(3))) // mismatch

assertThat(x, greaterThan(1) && lessThan(3))
assertThat(x, greaterThan(2) && lessThan(3)) // mismatch

assertThat(x, anyOf(greaterThan(2), lessThan(3)))
assertThat(x, anyOf(greaterThan(2), lessThan(2))) // mismatch

assertThat(x, greaterThan(2) || lessThan(3))
assertThat(x, greaterThan(2) || lessThan(2)) // mismatch

//: ### Collections
//: Combining matchers is particularly useful for matching sequences and dictionaries.

let array = ["foo", "bar"]

assertThat(array, hasCount(2))
assertThat(array, hasCount(greaterThan(2))) // mismatch

assertThat(array, everyItem(equalTo("foo"))) // mismatch

assertThat(array, contains("foo", "bar"))
assertThat(array, contains(equalTo("foo"), equalTo("bar")))
assertThat(array, contains(equalTo("foo"))) // mismatch
assertThat(array, contains(equalTo("foo"), equalTo("baz"))) // mismatch
assertThat(array, contains(equalTo("foo"), equalTo("bar"), equalTo("baz"))) // mismatch

assertThat(array, containsInAnyOrder("bar", "foo"))
assertThat(array, containsInAnyOrder(equalTo("bar"), equalTo("foo")))

assertThat(array, hasItem(equalTo("foo")))
assertThat(array, hasItem(equalTo("baz"))) // mismatch

assertThat(array, hasItems("foo", "bar"))
assertThat(array, hasItems(equalTo("foo"), equalTo("baz"))) // mismatch

let dictionary = ["foo": 5, "bar": 10]

assertThat(dictionary, hasEntry("foo", 5))
assertThat(dictionary, hasEntry(equalTo("foo"), equalTo(5)))
assertThat(dictionary, hasEntry(equalTo("foo"), equalTo(10))) // mismatch

assertThat(dictionary, hasKey("foo"))
assertThat(dictionary, hasKey(equalTo("baz"))) // mismatch

assertThat(dictionary, hasValue(10))
assertThat(dictionary, hasValue(equalTo(15))) // mismatch

//: ### Optional types
//: Matchers don't expect optional types to match Swift's favoring of non-nilable types. presentAnd can be explicitly apply a matcher to an optional type.

var optional: Int = 1 + 1

assertThat(optional, present())
assertThat(optional, nilValue()) // mismatch

assertThat(optional, presentAnd(equalTo(2)))
assertThat(optional, presentAnd(equalTo(1))) // mismatch

//: ### Types and Casts
//: The following matchers can be used to assert types. References of type Any need to be cast before typed matchers can be used. instanceOf(and:) can be used to combine type verification and casting.

class TestChild: Test {}
assertThat(o, instanceOf(Test))
assertThat(o, instanceOf(TestChild)) // mismatch

let any: Any = 10
assertThat(any, instanceOf(Int.self, and: equalTo(10)))
assertThat(any, instanceOf(Double.self, and: equalTo(10.0))) // mismatch
assertThat(any, instanceOf(Int.self, and: equalTo(5))) // mismatch

//: ### Custom Matchers
//: There are two ways of creating custom matchers. The first way is to create a function that simply returns a combination of existing matchers.

func isOnAxis<Point>() -> Matcher<Point> {
    return anyOf(hasProperty("x", closeTo(0.0, 0.00001)),
        hasProperty("y", closeTo(0.0, 0.00001)))
}

assertThat(CGPoint(x: 0, y: 10), isOnAxis())
assertThat(CGPoint(x: 5, y: 10), isOnAxis()) // mismatch

//: You can use the special matcher describedAs to customize the description.

func isOnAxis2<Point>() -> Matcher<Point> {
    return describedAs("a point on an axis",
        anyOf(hasProperty("x", closeTo(0.0, 0.00001)),
            hasProperty("y", closeTo(0.0, 0.00001))))
}

assertThat(CGPoint(x: 0, y: 10), isOnAxis2())
assertThat(CGPoint(x: 5, y: 10), isOnAxis2()) // mismatch

//: The second way is to create a matcher from scratch. SwiftHamcrest particularly focuses on making this kind of custom matchers easy to write. In many Hamcrest implementations, you usually create a class for this. In SwiftHamcrest, you just create an instance of Matcher with a custom closure that takes a value and returns a Bool.

func isEven() -> Matcher<Int> {
    return Matcher("even") {$0 % 2 == 0}
}

assertThat(x, isEven())
assertThat(3, isEven()) // mismatch

//: While a Bool is convenient (and sufficient in most cases), there are occasions where you want more information about the mismatch. Instead of a Bool you can also have the closure return a MatchResult enum. This is especially useful if the mismatch isn't obvious.

func isDivisibleByThree() -> Matcher<Int> {
    return Matcher("divisible by three") {
        (value) -> MatchResult in
        if value % 3 == 0 {
            return .Match
        } else {
            return .Mismatch("remainder: \(value % 3)")
        }
    }
}

assertThat(342783, isDivisibleByThree())
assertThat(489359, isDivisibleByThree()) // mismatch
