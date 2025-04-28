//
//  SwiftTestIntegrationTests.swift
//  HamcrestTests
//
//  Created by René Pirringer on 13.09.24.
//

import Hamcrest
import HamcrestSwiftTesting
import Testing

struct SwiftTestIntegrationTests {
    @Test func test_assertThat() async throws {
        __assertThat("foo", equalTo("foo"), sourceLocation: Testing.SourceLocation.__here())
        __assertThat("foo", not(equalTo("bar")), sourceLocation: Testing.SourceLocation.__here())
    }

    @Test func test_assertThat_macro() async throws {
        #if canImport(HamcrestSwiftTestingMacros)
        #assertThat("foo", equalTo("foo"))
        #assertThat("foo", not(equalTo("bar")))
        #else
            throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    @Test func test_enable() async throws {
        HamcrestSwiftTesting.enable()

        #expect(Hamcrest.SwiftTestingHamcrestReportFunction != nil)
    }
}
