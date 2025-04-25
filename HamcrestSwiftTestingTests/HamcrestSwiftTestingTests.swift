//
//  HamcrestSwiftTestingTests.swift
//  HamcrestSwiftTestingTests
//
//  Created by René Pirringer on 11.04.25.
//  Copyright © 2025 All rights reserved.
//

import Hamcrest
import Testing

class HamcrestSwiftTestingTests {
    var reportedError: String?

    init() async throws {
        Hamcrest.HamcrestReportFunction = {message, fileId, file, line, column in self.reportedError = message}
    }

    @Test func assertThat() async throws {
        let value = "foo"
        Hamcrest.assertThat(value, equalTo("bar"))
        #expect(reportedError == "GOT: \"foo\", EXPECTED: equal to bar")
    }
}
