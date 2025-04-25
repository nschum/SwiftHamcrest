//
//  HamcrestReporter.swift
//  Hamcrest
//
//  Created by René Pirringer on 25.04.25.
//  Copyright © 2025. All rights reserved.
//

import XCTest

/// Reporter function that is called whenever a Hamcrest assertion fails.
/// By default this calls XCTFail, except in Playgrounds where it does nothing.
/// This is intended for testing Hamcrest itself.
///
public typealias HamcrestReporterFunctionClosure = (_: String, _ fileID: String, _ file: StaticString, _ line: UInt, _ column: UInt) -> ()
nonisolated(unsafe) public var HamcrestReportFunction: HamcrestReporterFunctionClosure = HamcrestDefaultReportFunction
nonisolated(unsafe) public let HamcrestDefaultReportFunction = isPlayground() ? {message, fileID, file, line, column in} : {message, fileID, file, line, column in reporterFunction(message, fileID: fileID, file: file, line: line, column: column)}

// MARK: helpers

func reporterFunction(_ message: String = "", fileID: String, file: StaticString, line: UInt, column: UInt) {
    XCTFail(message, file: file, line: line)
}
