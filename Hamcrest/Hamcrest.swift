import Foundation
import Swift
import XCTest

/// Reporter function that is called whenever a Hamcrest assertion fails.
/// By default this calls XCTFail, except in Playgrounds where it does nothing.
/// This is intended for testing Hamcrest itself.
///
///
///
public typealias HamcrestReportFunctionClosure = (_: String, _ fileID: String, _ file: StaticString, _ line: UInt, _ column: UInt) -> ()
nonisolated(unsafe) public var HamcrestReportFunction: HamcrestReportFunctionClosure = HamcrestDefaultReportFunction
nonisolated(unsafe) public let HamcrestDefaultReportFunction = isPlayground() ? { message, fileID, file, line, column in} : {message, fileID, file, line, column in reporterFunction(message, fileID: fileID, file: file, line: line, column: column)}
nonisolated(unsafe) public var SwiftTestingHamcrestReportFunction: HamcrestReportFunctionClosure?

// MARK: helpers

func reporterFunction(_ message: String = "", fileID: String, file: StaticString, line: UInt, column: UInt) {
    SwiftTestingHamcrestReportFunction?(message, fileID, file, line, column)
    XCTFail(message, file: file, line: line)
}

func filterNotNil<T>(_ array: [T?]) -> [T] {
    return array.filter({$0 != nil}).map({$0!})
}

func delegateMatching<T>(_ value: T, _ matcher: Matcher<T>, _ mismatchDescriber: (String?) -> String?) -> MatchResult {
    switch matcher.matches(value) {
    case .match:
        return .match
    case let .mismatch(mismatchDescription):
        return .mismatch(mismatchDescriber(mismatchDescription))
    }
}

func equalToWithoutDescription<T: Equatable>(_ expectedValue: T) -> Matcher<T> {
    return describedAs(describe(expectedValue), equalTo(expectedValue))
}

func isPlayground() -> Bool {
    let infoDictionary = Bundle.main.infoDictionary
    let bundleIdentifier = infoDictionary?["CFBundleIdentifier"]
    return (bundleIdentifier as? String)?.hasPrefix("com.apple.dt.Xcode") ?? false
}

// MARK: assertThrows

@discardableResult public func assertThrows<T>(_ value: @autoclosure () throws -> T, file: StaticString = #file, line: UInt = #line) -> String {
    do {
        _ = try value()
        return reportResult(describeExpectedError(), file: file, line: line)
    } catch {
        return reportResult(nil, file: file, line: line)
    }
}

@discardableResult public func assertThrows<S, T: Error>(_ value: @autoclosure () throws -> S, _ error: T, file: String = #file, line: UInt = #line) -> String where T: Equatable {
	return assertThrows(try value(), equalToWithoutDescription(error), file: file, line: line)
}

@discardableResult public func assertThrows<S, T: Error>(_ value: @autoclosure () throws -> S, _ matcher: Matcher<T>, file: String = #file, line: UInt = #line) -> String {
    return reportResult(applyErrorMatcher(matcher, toBlock: value))
}

@discardableResult private func applyErrorMatcher<S, T: Error>(_ matcher: Matcher<T>, toBlock: () throws -> S) -> String? {
    do {
        _ = try toBlock()
        return describeExpectedError(matcher.description)
    } catch let error as T {
        let match = matcher.matches(error)
        switch match {
        case .match:
            return nil
        case let .mismatch(mismatchDescription):
            return describeErrorMismatch(error, matcher.description, mismatchDescription)
        }
    } catch let error {
        return describeErrorMismatch(error, matcher.description, nil)
    }
}

// MARK: assertNotThrows

@discardableResult public func assertNotThrows<T>(_ value: @autoclosure () throws -> T, file: StaticString = #file, line: UInt = #line) -> String {
    do {
        _ = try value()
        return reportResult(nil, file: file, line: line)
    } catch {
        return reportResult(describeUnexpectedError(), file: file, line: line)
    }
}

// MARK: assertThat

@discardableResult public func assertThat<T>(_ value: @autoclosure () throws -> T, _ matcher: Matcher<T>, message: String? = nil, fileID: String = #fileID, file: StaticString = #file, line: UInt = #line) -> String {
    return reportResult(applyMatcher(matcher, toValue: value), message: message, fileID: fileID, file: file, line: line)
}

@discardableResult public func applyMatcher<T>(_ matcher: Matcher<T>, toValue: () throws -> T) -> String? {
    do {
        let value = try toValue()
        let match = matcher.matches(value)
        switch match {
        case .match:
            return nil
        case let .mismatch(mismatchDescription):
            return describeMismatch(value, matcher.description, mismatchDescription)
        }
    } catch let error {
        return describeError(error)
    }
}

func reportResult(_ possibleResult: String?, message: String? = nil, fileID: String = #fileID, file: StaticString = #file, line: UInt = #line, column: UInt = #column)
    -> String {
    if let possibleResult = possibleResult {
        let result: String
        if let message = message {
            result = "\(message) - \(possibleResult)"
        } else {
            result = possibleResult
        }
        HamcrestReportFunction(result, fileID, file, line, column)
        return result
    } else {
        // The return value is just intended for Playgrounds.
        return "✓"
    }
}
