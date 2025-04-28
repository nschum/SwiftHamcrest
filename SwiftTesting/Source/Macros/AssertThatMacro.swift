//
//  AssesrtThatMacro.swift
//  Hamcrest
//
//  Created by René Pirringer on 13.09.24.
//

import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxMacros

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
         return "__assertThat(\(firstArgument), \(secondArgument), sourceLocation: Testing.SourceLocation.__here())"
    }
}

@main
struct HamcrestMacroPlugin: CompilerPlugin {
    public init() {}

    public let providingMacros: [Macro.Type] = [
        AssertThatMacro.self
    ]
}
