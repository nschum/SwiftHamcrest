//
//  SwiftTesting.swift
//  Hamcrest
//
//  Created by René Pirringer on 13.09.24.
//
import Foundation
import Hamcrest
import SwiftSyntax
import SwiftSyntaxMacros
import Testing

@_disfavoredOverload public func __assertThat<T>(
    _ value: @autoclosure () throws -> T,
    _ matcher: Matcher<T>,
    sourceLocation: Testing.SourceLocation
) {
    if let message = applyMatcher(matcher, toValue: value) {
        Issue.record(Testing.Comment(rawValue: message), sourceLocation: sourceLocation)
    }
}

@freestanding(expression) public macro assertThat<T>(
    _ value: @autoclosure () throws -> T,
    _ matcher: Matcher<T>,
  _ comment: @autoclosure () -> Comment? = nil,
    sourceLocation: Testing.SourceLocation = #_sourceLocation
) = #externalMacro(module: "HamcrestSwiftTestingMacros", type: "AssertThatMacro")
