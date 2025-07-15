// swift-tools-version:6.0

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "Hamcrest",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        .library(name: "Hamcrest", targets: ["Hamcrest"]),
        .library(name: "HamcrestSwiftTesting", targets: ["HamcrestSwiftTesting"])
    ],
    targets: [
        .target(
            name: "Hamcrest",
            dependencies: [],
            path: "Hamcrest",
            sources: [
                "Main/Source"
            ],
        ),
        .testTarget(
            name: "HamcrestTests",
            dependencies: [
                "Hamcrest"
            ],
            path: "Hamcrest",
            sources: [
                "Main/Test"
            ]
        ),
        .target(
            name: "HamcrestSwiftTesting",
            dependencies: [
                "Hamcrest"
            ],
            path: "Hamcrest",
            sources: [
                "SwiftTesting/Source"
            ]
        ),
        .testTarget(
            name: "HamcrestSwiftTestingTests",
            dependencies: [
                "Hamcrest",
                "HamcrestSwiftTesting"
            ],
            path: "Hamcrest",
            sources: [
                "SwiftTesting/Test"
            ]
        )

    ]
)
