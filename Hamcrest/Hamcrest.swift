import Foundation
import Swift
import XCTest

/// Reporter function that is called whenever a Hamcrest assertion fails.
/// By default this calls XCTFail, except in Playgrounds where it does nothing.
/// This is intended for testing Hamcrest itself.
public var HamcrestReportFunction: (_: String, file: String, line: UInt) -> () = HamcrestDefaultReportFunction
public let HamcrestDefaultReportFunction =
    isPlayground()
        ? {(message, file, line) in}
        : {(message, file, line) in XCTFail(message, file: file, line: line)}

// MARK: helpers

func filterNotNil<T>(array: [T?]) -> [T] {
    return array.filter({$0 != nil}).map({$0!})
}

func delegateMatching<T>(value: T, _ matcher: Matcher<T>, _ mismatchDescriber: String? -> String?) -> MatchResult {
    switch matcher.matches(value) {
    case .Match:
        return .Match
    case let .Mismatch(mismatchDescription):
        return .Mismatch(mismatchDescriber(mismatchDescription))
    }
}

func equalToWithoutDescription<T: Equatable>(expectedValue: T) -> Matcher<T> {
    return describedAs(describe(expectedValue), equalTo(expectedValue))
}

func isPlayground() -> Bool {
    let infoDictionary = NSBundle.mainBundle().infoDictionary
    let bundleIdentifier: AnyObject? = infoDictionary?["CFBundleIdentifier"]
    return (bundleIdentifier as? String)?.hasPrefix("com.apple.dt.playground.stub") ?? false
}

// MARK: assertThrows

public func assertThrows<T>(@autoclosure value: () throws -> T, file: String = __FILE__, line: UInt = __LINE__) -> String {
    do {
        try value()
        return reportResult(describeExpectedError())
    } catch {
        return reportResult(nil)
    }
}

public func assertThrows<S, T: ErrorType where T: Equatable>(@autoclosure value: () throws -> S, _ error: T, file: String = __FILE__, line: UInt = __LINE__) -> String {
    return assertThrows(value, equalToWithoutDescription(error), file: file, line: line)
}

public func assertThrows<S, T: ErrorType>(@autoclosure value: () throws -> S, _ matcher: Matcher<T>, file: String = __FILE__, line: UInt = __LINE__) -> String {
    return reportResult(applyErrorMatcher(matcher, toBlock: value))
}

private func applyErrorMatcher<S, T: ErrorType>(matcher: Matcher<T>, @noescape toBlock: () throws -> S) -> String? {
    do {
        try toBlock()
        return describeExpectedError(matcher.description)
    } catch let error as T {
        let match = matcher.matches(error)
        switch match {
        case .Match:
            return nil
        case let .Mismatch(mismatchDescription):
            return describeErrorMismatch(error, matcher.description, mismatchDescription)
        }
    } catch let error {
        return describeErrorMismatch(error, matcher.description, nil)
    }
}

// MARK: assertThat

public func assertThat<T>(@autoclosure value: () throws -> T, _ matcher: Matcher<T>, file: String = __FILE__, line: UInt = __LINE__) -> String {
    return reportResult(applyMatcher(matcher, toValue: value), file: file, line: line)
}

func applyMatcher<T>(matcher: Matcher<T>, @noescape toValue: () throws -> T) -> String? {
    do {
        let value = try toValue()
        let match = matcher.matches(value)
        switch match {
        case .Match:
            return nil
        case let .Mismatch(mismatchDescription):
            return describeMismatch(value, matcher.description, mismatchDescription)
        }
    } catch let error {
        return describeError(error)
    }
}

func reportResult(possibleResult: String?, file: String = __FILE__, line: UInt = __LINE__)
    -> String {

    if let result = possibleResult {
        HamcrestReportFunction(result, file: file, line: line)
        return result
    } else {
        // The return value is just intended for Playgrounds.
        return "✓"
    }
}
