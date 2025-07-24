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

    @Test func test_enable() async throws {
        HamcrestSwiftTesting.enable()

        #expect(Hamcrest.SwiftTestingHamcrestReportFunction != nil)
    }
}
