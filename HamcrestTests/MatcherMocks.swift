import XCTest
import Hamcrest

func succeedingMatcher<T: Equatable>(expectingValue: T, description: String = "description",
                                     file: String = __FILE__, line: UInt = __LINE__) -> Matcher<T> {

    return Matcher<T>(description) {
        (value: T) -> Bool in
        XCTAssertEqual(value, expectingValue, file: file, line: line)
        return true
    }
}

func succeedingMatcher<T>(type: T.Type = T.self, description: String = "description")
    -> Matcher<T> {

    return Matcher<T>(description) {value in true}
}

func failingMatcher<T>(type: T.Type = T.self, description: String = "description",
                       mismatchDescription: String? = nil) -> Matcher<T> {

    return Matcher<T>(description) {value in .Mismatch(mismatchDescription)}
}

func failingMatcherWithMismatchDescription<T>(type: T.Type = T.self,
                                              description: String = "description") -> Matcher<T> {
    return failingMatcher(type: type, description: description, mismatchDescription: "mismatch description")
}