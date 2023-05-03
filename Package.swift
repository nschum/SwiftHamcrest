// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "Hamcrest",
    products: [
        .library(name: "Hamcrest", targets: ["SwiftHamcrest"]),
    ],
    targets: [
        .target(name: "SwiftHamcrest", dependencies: [], path: "Hamcrest"),
        .testTarget(name: "SwiftHamcrestTests", dependencies: ["SwiftHamcrest"], path: "HamcrestTests"),
    ]
)
