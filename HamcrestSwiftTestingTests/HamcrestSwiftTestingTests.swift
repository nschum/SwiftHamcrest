//
//  HamcrestSwiftTestingTests.swift
//  HamcrestSwiftTestingTests
//
//  Created by René Pirringer on 11.04.25.
//  Copyright © 2025 All rights reserved.
//

import HamcrestCore
import HamcrestSwiftTesting
import Testing

class HamcrestSwiftTestingTests {
    var reportedError: String?

    init() async throws {
        HamcrestReportFunction = {message, fileId, file, line, column in self.reportedError = message}
    }

    @Test func assertThat_test() async throws {
        let value = "foo"
        assertThat(value, equalTo("bar"))
        #expect(reportedError == "GOT: \"foo\", EXPECTED: equal to bar")
    }
}
