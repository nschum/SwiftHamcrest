//
//  AssertThat.swift
//  Hamcrest
//
//  Created by René Pirringer on 28.04.25.
//  Copyright © 2025 Nikolaj Schumacher. All rights reserved.
//
import HamcrestCore
import Testing

@discardableResult public func assertThat<T>(_ value: @autoclosure () throws -> T, _ matcher: Matcher<T>, message: String? = nil, fileID: String = #fileID, file: StaticString = #file, line: UInt = #line) -> String {
    enableSwiftTestingReporing()
    return reportResult(applyMatcher(matcher, toValue: value), message: message, fileID: fileID, file: file, line: line)
}

func enableSwiftTestingReporing() {
    SwiftTestingHamcrestReportFunction = { message, fileID, file, line, column in
        let location = Testing.SourceLocation(fileID: fileID, filePath: "\(file)", line: Int(line), column: Int(column))
        Issue.record(Testing.Comment(rawValue: message), sourceLocation: location)
    }
}
