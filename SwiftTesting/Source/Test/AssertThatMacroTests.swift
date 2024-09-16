//
//  AssertThatMacroTests.swift
//  HamcrestTests
//
//  Created by René Pirringer on 16.09.24.
//
import HamcrestSwiftTestingMacros
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(HamcrestSwiftTestingMacros)
import HamcrestSwiftTestingMacros

let testMacros: [String: Macro.Type] = [
    "assertThat": AssertThatMacro.self
]

#endif

final class AssertThatMacroTests: XCTestCase {
    func test_macro_syntax_with_equal_int() throws {
        #if canImport(HamcrestSwiftTestingMacros)

        assertMacroExpansion(
                             """
                              #assertThat(1, equalTo(1))
                              """, expandedSource:
                             """
                              checkMatcher(1, equalTo(1), comments: [], isRequired: false, sourceLocation: Testing.SourceLocation.__here()).__expected()
                              """,
                             macros: testMacros)
        #else
            throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func test_macro_syntax_with_equal_string() throws {
        #if canImport(HamcrestSwiftTestingMacros)

        assertMacroExpansion(
                             """
                              #assertThat("1", equalTo("1"))
                              """, expandedSource:
                             """
                              checkMatcher("1", equalTo("1"), comments: [], isRequired: false, sourceLocation: Testing.SourceLocation.__here()).__expected()
                              """,
                             macros: testMacros)
        #else
            throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
