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

@_disfavoredOverload public func checkMatcher<T>(
    _ value: @autoclosure () throws -> T,
    _ matcher: Matcher<T>,
    comments: @autoclosure () -> [Comment],
    isRequired: Bool,
    sourceLocation: Testing.SourceLocation
) -> Result<Void, any Error> {
    if let message = applyMatcher(matcher, toValue: value) {
        let expression = Testing.__Expression.__fromSyntaxNode(message)
        return __checkValue(
            false,
            expression: expression,
            expressionWithCapturedRuntimeValues: expression,
            comments: comments(),
            isRequired: isRequired,
            sourceLocation: sourceLocation
        )
    }
    return .success(())
}

@freestanding(expression) public macro assertThat<T>(
    _ value: @autoclosure () throws -> T,
    _ matcher: Matcher<T>,
  _ comment: @autoclosure () -> Comment? = nil,
    sourceLocation: Testing.SourceLocation = #_sourceLocation
) = #externalMacro(module: "HamcrestSwiftTestingMacros", type: "AssertThatMacro")
