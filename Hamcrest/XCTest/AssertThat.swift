//
//  HamcrestReporter.swift
//  Hamcrest
//
//  Created by René Pirringer on 25.04.25.
//  Copyright © 2025. All rights reserved.
//

import HamcrestCore
import XCTest

@discardableResult public func assertThat<T>(_ value: @autoclosure () throws -> T, _ matcher: Matcher<T>, message: String? = nil, fileID: String = #fileID, file: StaticString = #file, line: UInt = #line) -> String {
    return reportResult(applyMatcher(matcher, toValue: value), message: message, fileID: fileID, file: file, line: line)
}
