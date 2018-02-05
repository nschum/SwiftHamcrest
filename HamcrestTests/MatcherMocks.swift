import Hamcrest
import XCTest

func succeedingMatcher<T: Equatable>(_ expectingValue: T, description: String = "description",
                                     file: StaticString = #file, line: UInt = #line) -> Matcher<T> {

    return Matcher<T>(description) {
        (value: T) -> Bool in
        XCTAssertEqual(value, expectingValue, file: file, line: line)
        return true
    }
}

func succeedingMatcher<T>(_ type: T.Type = T.self, description: String = "description")
    -> Matcher<T> {

    return Matcher<T>(description) {value in true}
}

func failingMatcher<T>(_ type: T.Type = T.self, description: String = "description",
                       mismatchDescription: String? = nil) -> Matcher<T> {

    return Matcher<T>(description) {value in .mismatch(mismatchDescription)}
}

func failingMatcherWithMismatchDescription<T>(_ type: T.Type = T.self,
                                              description: String = "description") -> Matcher<T> {
    return failingMatcher(type, description: description, mismatchDescription: "mismatch description")
}
