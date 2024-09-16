//
//  SwiftTestIntegrationTests.swift
//  HamcrestTests
//
//  Created by René Pirringer on 13.09.24.
//

import Testing
import Hamcrest
import HamcrestSwiftTesting

struct SwiftTestIntegrationTests {

    @Test func test_checkMatcher() async throws {
        checkMatcher("foo", equalTo("foo"), comments: [], isRequired: false, sourceLocation: Testing.SourceLocation.__here()).__expected()
        checkMatcher("foo", not(equalTo("bar")), comments: [], isRequired: false, sourceLocation: Testing.SourceLocation.__here()).__expected()
    }


    @Test func test_assertThat_macro() async throws {
        #if canImport(HamcrestSwiftTestingMacros)
        #assertThat("foo", equalTo("foo"))
        #assertThat("foo", not(equalTo("bar")))
        #else
            throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }


}

