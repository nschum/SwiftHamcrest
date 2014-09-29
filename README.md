Swift Hamcrest
==============

Hamcrest gives you advanced matchers with better error messages for your Swift unit tests.

Hamcrest was originally written in Java and is available for many [languages](http://hamcrest.org).

Integration
-----------

While it is possible to use a compiled framework, for now I suggest to add Hamcrest as a project in your workspace. An OS X and an iOS demo project is included to demonstrate this. (Once CocoaPods supports Swift, a spec will be available.)

Tutorial
--------

**This tutorial is also available as a Playground in the Hamcrest workspace on Xcode 6.1 (Beta).**

Normally, you use these matchers in unit tests, where a mismatch will cause the test to fail, but they also work in Playgrounds, where a mismatch will simply print the error message.

In either case, the Hamcrest module needs to be imported.

```swift
import Hamcrest
```

### Operator Matchers ###

The following are very simply matchers. The matched expressions look like regular boolean expressions, but provide readable mismatch messages instead of a generic error.

```swift
let x = 1 + 1

// The comments show the human-readable error messages created by the assertions.

assertThat(x == 2) // 👍
assertThat(x == 3) // GOT: 2, EXPECTED: equal to 3

assertThat(x > 1) // 👍
assertThat(x > 2) // GOT: 2, EXPECTED: greater than 2

assertThat(x >= 2) // 👍
assertThat(x >= 3) // GOT: 2, EXPECTED: greater than or equal to 3

assertThat(x < 3) // 👍
assertThat(x < 2) // GOT: 2, EXPECTED: greater than 2

assertThat(x <= 2) // 👍
assertThat(x <= 1) // GOT: 2, EXPECTED: greater than or equal to 1

class Test {}
let o = Test()
assertThat(o === o) // 👍
assertThat(o === Test())
// GOT: __lldb_expr_8.Test (0x7f9572b020d0),
// EXPECTED: same instance as 0x7f9570c702a0
```

### Textual Matchers ###

All these matchers are also available as functions.

```swift
assertThat(x, equalTo(2)) // 👍
assertThat(x, equalTo(3)) // GOT: 2, EXPECTED: equal to 3

assertThat(x, greaterThan(1)) // 👍
assertThat(x, greaterThan(2)) // GOT: 2, EXPECTED: greater than 2

assertThat(x, greaterThanOrEqualTo(2)) // 👍
assertThat(x, greaterThanOrEqualTo(3))
// GOT: 2, EXPECTED: greater than or equal to 3

assertThat(x, lessThan(3)) // 👍
assertThat(x, lessThan(2)) // GOT: 2, EXPECTED: greater than 2

assertThat(x, lessThanOrEqualTo(2)) // 👍
assertThat(x, lessThanOrEqualTo(1))
// GOT: 2, EXPECTED: greater than or equal to 1

assertThat(x, inInterval(1...2)) // 👍
assertThat(x, inInterval(1..<2)) // GOT: 2, EXPECTED: in interval 1..<2

assertThat(o, sameInstance(o)) // 👍
assertThat(o, sameInstance(Test()))
// GOT: __lldb_expr_53.Test, EXPECTED: same instance as __lldb_expr_53.Test
```

Here are some more straightforward matchers:

```swift
assertThat("foobarbaz", containsString("bar")) // 👍
assertThat("foobarbaz", containsString("bla"))
// GOT: "foobarbaz", EXPECTED: contains "bla"

assertThat("foobarbaz", containsStringsInOrder("f", "b", "b")) // 👍
assertThat("foobarbaz", containsStringsInOrder("foo", "baz", "bar"))
// GOT: "foobarbaz", EXPECTED: contains in order ["foo", "baz", "bar"]

assertThat("foobarbaz", hasPrefix("foo")) // 👍
assertThat("foobarbaz", hasPrefix("oo"))
// GOT: "foobarbaz", EXPECTED: has prefix "oo"

assertThat("foobarbaz", hasSuffix("baz")) // 👍
assertThat("foobarbaz", hasSuffix("ba"))
// GOT: "foobarbaz", EXPECTED: has suffix "ba"

assertThat(10.0, closeTo(10.0, 0.01)) // 👍
assertThat(10.0000001, closeTo(10, 0.01)) // 👍
assertThat(10.1, closeTo(10, 0.01))
// GOT: 10.1 (difference of 0.0999999999999996), EXPECTED: within 0.01 of 10.0

import Foundation
assertThat(CGPoint(x: 5, y: 10), hasProperty("x", closeTo(5.0, 0.00001))) // 👍
assertThat(CGPoint(x: 5, y: 10), hasProperty("y", closeTo(0.0, 0.00001)))
// GOT: (5.0,10.0) (property value 10.0 (difference of 10.0)),
// EXPECTED: has property "y" with value within 1e-05 of 0.0
```

### Combining Matchers ###

The real power of Hamcrest comes combining multiple matchers into a single assertion statement.

```swift
assertThat(x, not(equalTo(3))) // 👍
assertThat(x, not(equalTo(2))) // GOT: 2, EXPECTED: not equal to 2

assertThat(x, allOf(greaterThan(1), lessThan(3))) // 👍
assertThat(x, allOf(greaterThan(2), lessThan(3)))
// GOT: 2 (mismatch: greater than 2),
// EXPECTED: all of [greater than 2, greater than 3]

assertThat(x, greaterThan(1) && lessThan(3)) // 👍
assertThat(x, greaterThan(2) && lessThan(3))
// GOT: 2 (mismatch: greater than 2),
// EXPECTED: all of [greater than 2, greater than 3]

assertThat(x, anyOf(greaterThan(2), lessThan(3))) // 👍
assertThat(x, anyOf(greaterThan(2), lessThan(2)))
// GOT: 2, EXPECTED: any of [greater than 2, greater than 2]

assertThat(x, greaterThan(2) || lessThan(3)) // 👍
assertThat(x, greaterThan(2) || lessThan(2))
// GOT: 2, EXPECTED: any of [greater than 2, greater than 2]
```

### Collections ###

Combining matchers is particularly useful for matching sequences and dictionaries.

```swift
let array = ["foo", "bar"]

assertThat(array, hasCount(2)) // 👍
assertThat(array, hasCount(greaterThan(2)))
// GOT: [foo, bar] (count 2), EXPECTED: has count greater than 2

assertThat(array, everyItem(equalTo("foo")))
// GOT: [foo, bar] (mismatch: bar),
// EXPECTED: a sequence where every item equal to foo

assertThat(array, contains("foo", "bar")) // 👍
assertThat(array, contains(equalTo("foo"), equalTo("bar"))) // 👍
assertThat(array, contains(equalTo("foo")))
// GOT: [foo, bar] (unmatched item "bar"),
// EXPECTED: a sequence containing equal to foo
assertThat(array, contains(equalTo("foo"), equalTo("baz")))
// "GOT: [foo, bar] (mismatch: GOT: "bar", EXPECTED: equal to baz),
// EXPECTED: a sequence containing [equal to foo, equal to baz]"
assertThat(array, contains(equalTo("foo"), equalTo("bar"), equalTo("baz")))
// GOT: [foo, bar] (missing item equal to baz),
// EXPECTED: a sequence containing [equal to foo, equal to bar, equal to baz]

assertThat(array, containsInAnyOrder("bar", "foo")) // 👍
assertThat(array, containsInAnyOrder(equalTo("bar"), equalTo("foo"))) // 👍

assertThat(array, hasItem(equalTo("foo"))) // 👍
assertThat(array, hasItem(equalTo("baz")))
// GOT: [foo, bar], EXPECTED: a sequence containing equal to baz

assertThat(array, hasItems("foo", "bar")) // 👍
assertThat(array, hasItems(equalTo("foo"), equalTo("baz")))
// GOT: [foo, bar] (missing item equal to baz),
// EXPECTED: a sequence containing all of [equal to foo, equal to baz]
```
```swift
let dictionary = ["foo": 5, "bar": 10]

assertThat(dictionary, hasEntry("foo", 5)) // 👍
assertThat(dictionary, hasEntry(equalTo("foo"), equalTo(5))) // 👍
assertThat(dictionary, hasEntry(equalTo("foo"), equalTo(10)))
// GOT: [bar: 10, foo: 5],
// EXPECTED: a dictionary containing [equal to foo -> equal to 10]

assertThat(dictionary, hasKey("foo")) // 👍
assertThat(dictionary, hasKey(equalTo("baz")))
// GOT: [bar: 10, foo: 5],
// EXPECTED: a dictionary containing [equal to baz -> anything]

assertThat(dictionary, hasValue(10)) // 👍
assertThat(dictionary, hasValue(equalTo(15)))
// GOT: [bar: 10, foo: 5],
// EXPECTED: a dictionary containing [anything -> equal to 15]
```

### Optional types ###

Matchers don't expect optional types to match Swift's favoring of non-nilable types. presentAnd can be explicitly apply a matcher to an optional type.

```swift
var optional: Int = 1 + 1

assertThat(optional, present()) // 👍
assertThat(optional, nilValue()) // GOT: Optional(2), EXPECTED: nil

assertThat(optional, presentAnd(equalTo(2))) // 👍
assertThat(optional, presentAnd(equalTo(1)))
// GOT: Optional(2), EXPECTED: present and equal to 1
```

### Types and Casts ###

The following matchers can be used to assert types. References of type Any need to be cast before typed matchers can be used. instanceOf(and:) can be used to combine type verification and casting.

```swift
class TestChild: Test {}
assertThat(o, instanceOf(Test)) // 👍
assertThat(o, instanceOf(TestChild))
// GOT: __lldb_expr_60.Test, EXPECTED: instance of expected type

let any: Any = 10
assertThat(any, instanceOf(Int.self, and: equalTo(10))) // 👍
assertThat(any, instanceOf(Double.self, and: equalTo(10.0)))
// GOT: 10 (mismatched type), EXPECTED: instance of and equal to 10.0
assertThat(any, instanceOf(Int.self, and: equalTo(5)))
// GOT: 10, EXPECTED: instance of and equal to 5
```

### Custom Matchers ###

There are two ways of creating custom matchers. The first way is to create a function that simply returns a combination of existing matchers.

```swift
func isOnAxis<Point>() -> Matcher<Point> {
    return anyOf(hasProperty("x", closeTo(0.0, 0.00001)),
                 hasProperty("y", closeTo(0.0, 0.00001)))
}

assertThat(CGPoint(x: 0, y: 10), isOnAxis()) // 👍
assertThat(CGPoint(x: 5, y: 10), isOnAxis())
// GOT: (5.0,10.0),
// EXPECTED: any of [has property "x" with value within 1e-05
// of 0.0, has property "y" with value within 1e-05 of 0.0]
```

You can use the special matcher describedAs to customize the description.

```swift
func isOnAxis2<Point>() -> Matcher<Point> {
    return describedAs("a point on an axis",
        anyOf(hasProperty("x", closeTo(0.0, 0.00001)),
              hasProperty("y", closeTo(0.0, 0.00001))))
}

assertThat(CGPoint(x: 0, y: 10), isOnAxis2()) // 👍
assertThat(CGPoint(x: 5, y: 10), isOnAxis2())
// GOT: (5.0,10.0), EXPECTED: a point on an axis
```

The second way is to create a matcher from scratch. SwiftHamcrest particularly focuses on making this kind of custom matchers easy to write. In many Hamcrest implementations, you usually create a class for this. In SwiftHamcrest, you just create an instance of Matcher with a custom closure that takes a value and returns a Bool.

```swift
func isEven() -> Matcher<Int> {
    return Matcher("even") {$0 % 2 == 0}
}

assertThat(x, isEven()) // 👍
assertThat(3, isEven()) // GOT: 3, EXPECTED: even
```

While a Bool is convenient (and sufficient in most cases), there are occasions where you want more information about the mismatch. Instead of a Bool you can also have the closure return a MatchResult enum. This is especially useful if the mismatch isn't obvious.

```swift
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

assertThat(342783, isDivisibleByThree()) // 👍
assertThat(489359, isDivisibleByThree())
// GOT: 489359 (remainder: 2), EXPECTED: divisible by three
```
