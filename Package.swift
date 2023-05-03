// swift-tools-version:4.2
// Managed by ice

import PackageDescription

let package = Package(
    name: "SwiftHamcrest",
    products: [
        .library(name: "SwiftHamcrest", targets: ["SwiftHamcrest"]),
    ],
    targets: [
        .target(name: "SwiftHamcrest", dependencies: [], path: "Hamcrest"),
        .testTarget(name: "SwiftHamcrestTests", dependencies: ["SwiftHamcrest"], path: "HamcrestTests"),
    ]
)
