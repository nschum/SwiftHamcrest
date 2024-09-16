//
//  AssesrtThatMacro.swift
//  Hamcrest
//
//  Created by René Pirringer on 13.09.24.
//

import Foundation
import SwiftSyntax
import SwiftSyntaxMacros
import SwiftCompilerPlugin

public struct AssertThatMacro: ExpressionMacro, Sendable {

    public static func expansion(of node: some SwiftSyntax.FreestandingMacroExpansionSyntax, in context: some SwiftSyntaxMacros.MacroExpansionContext) throws -> SwiftSyntax.ExprSyntax {

        let arguments = node.arguments
        guard arguments.count == 2 else {
            fatalError("the macro does not have proper arguments")
        }

        var iterator = arguments.makeIterator()
        guard let firstArgument = iterator.next()?.expression else {
            fatalError("the argument expression is missing")
        }
        guard let secondArgument = iterator.next()?.expression else {
            fatalError("the argument expression is missing")
        }
         return "checkMatcher(\(firstArgument), \(secondArgument), comments: [], isRequired: false, sourceLocation: Testing.SourceLocation.__here()).__expected()"
    }


}

@main
struct HamcrestMacroPlugin: CompilerPlugin {
    public init() {}

    public let providingMacros: [Macro.Type] = [
        AssertThatMacro.self
    ]

}
