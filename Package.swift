// swift-tools-version:6.0

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Hamcrest",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(name: "Hamcrest", targets: ["Hamcrest"])
        .library(name: "HamcrestSwiftTesting", targets: ["HamcrestSwiftTesting"])
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest")
    ],
    targets: [
        .target(
            name: "Hamcrest",
            dependencies: [],
            path: "Hamcrest"),


        .testTarget(
            name: "HamcrestTests",
            dependencies: [
                "Hamcrest",
            ],
            path: "HamcrestTests"),

        .macro(
            name: "HamcrestSwiftTestingMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ],
            path: "SwiftTesting",
            sources: [
                "Source/Macros"
            ]
        ),

        .target(
            name: "HamcrestSwiftTesting",
            dependencies: [
                "HamcrestSwiftTestingMacros",
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ],
            path: "SwiftTesting",
            sources: [
                "Source/Main"
            ]
        ),

        .testTarget(
            name: "HamcrestSwiftTestingTests",
            dependencies: [
                "Hamcrest",
                "HamcrestSwiftTesting",
                "HamcrestSwiftTestingMacros",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
            ],
            path: "SwiftTesting",
            sources: [
                "Source/Test"
            ]
        )
    ]
)
