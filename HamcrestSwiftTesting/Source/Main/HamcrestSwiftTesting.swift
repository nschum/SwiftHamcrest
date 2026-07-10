//
//  HamcrestSwiftTesting.swift
//  Hamcrest
//
//  Created by René Pirringer on 10.07.26.
//  Copyright © 2026 Nikolaj Schumacher. All rights reserved.
//

import Foundation
import Swift
import Testing
import Hamcrest

public typealias SwiftTestingHamcrestReportFunctionClosure = (_: String, _ sourceLocation: Testing.SourceLocation) -> ()
nonisolated(unsafe) public var SwiftTestingHamcrestReportFunction: SwiftTestingHamcrestReportFunctionClosure = SwiftTestingHamcrestDefaultReportFunction
nonisolated(unsafe) public let SwiftTestingHamcrestDefaultReportFunction = { message, sourceLocation in reporterFunction(message, sourceLocation: sourceLocation)}

func reporterFunction(_ message: String = "", sourceLocation: Testing.SourceLocation) {
    Issue.record(Testing.Comment(rawValue: message), sourceLocation: sourceLocation)
}


@discardableResult public func assertThat<T>(_ value: @autoclosure () throws -> T, _ matcher: Matcher<T>, message: String? = nil, sourceLocation: Testing.SourceLocation = #_sourceLocation) -> String {
    return reportResult(applyMatcher(matcher, toValue: value), message: message, sourceLocation: sourceLocation)
}

func reportResult(_ possibleResult: String?, message: String? = nil, sourceLocation: Testing.SourceLocation) -> String {
    if let possibleResult = possibleResult {
        let result: String
        if let message = message {
            result = "\(message) - \(possibleResult)"
        } else {
            result = possibleResult
        }
        SwiftTestingHamcrestReportFunction(result, sourceLocation)
        return result
    } else {
        // The return value is just intended for Playgrounds.
        return "✓"
    }

}

@discardableResult public func assertThat(_ resultDescription: MatchResultDescription,
                                          _ sourceLocation: Testing.SourceLocation = #_sourceLocation) -> String {
    return reportResult(resultDescription.result, sourceLocation: sourceLocation)
}

