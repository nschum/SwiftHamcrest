//
//  Reporter.swift
//  Hamcrest
//
//  Created by René Pirringer on 28.04.25.
//
import Foundation
import Hamcrest
import Testing

public func enable() {
    Hamcrest.SwiftTestingHamcrestReportFunction = { message, fileID, file, line, column in
        let location = Testing.SourceLocation(fileID: fileID, filePath: "\(file)", line: Int(line), column: Int(column))
        Issue.record(Testing.Comment(rawValue: message), sourceLocation: location)
    }
}
