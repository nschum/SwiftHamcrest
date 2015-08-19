// Look at README.playground for a tutorial.

import Hamcrest

let x = 10
assertThat(x, equalTo(10))

enum MyErrors: ErrorType {
    case Foo(String?)
}

func testThrows() throws -> Int {
    throw MyErrors.Foo("x")
}

do {
    try testThrows()
} catch let error {
    print("\(error)")
}

func performTest<T: Equatable>(@autoclosure value: () throws -> T, _ expectedValue: T) -> String {
    do {
        return try value() == expectedValue ? "✓" : "✗"
    } catch let error {
        return "\(error)"
    }
}


performTest(0, 10)
performTest(try testThrows(), 10)
performTest(10, 10)

/*
func doesThrow<T>() -> Matcher<T> {
return Matcher("throws error") {$0 == expectedValue}
}
*/


/*
public func assertThrows(@autoclosure f: () throws -> (), file: String = __FILE__, line: UInt = __LINE__) -> String {
try {
f()
reportResult("EXPECTED"
} catch let error {

}

return reportResult(applyMatcher(matcher, toValue: value), file: file, line: line)
}

func assertThrows(@autoclosure f: () throws -> ()) {
try {
f()
} catch let error {

}
}
*/
