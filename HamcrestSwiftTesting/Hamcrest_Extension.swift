//
//  HamcrestSwiftTesting.swift
//  HamcrestSwiftTesting
//
//  Created by René Pirringer on 25.04.25.
//  Copyright © 2025 Nikolaj Schumacher. All rights reserved.
//

import Foundation
import Hamcrest
import Testing

public func enable() {
   SwiftTestingHamcrestReportFunction = swiftTestingReporterFunction
}

func swiftTestingReporterFunction(_ message: String = "", fileID: String, file: StaticString, line: UInt, column: UInt) {
    let location = Testing.SourceLocation(fileID: fileID, filePath: "\(file)", line: Int(line), column: Int(column))
    Issue.record(Testing.Comment(rawValue: message), sourceLocation: location)
}
