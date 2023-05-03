// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "Hamcrest",
    products: [
        .library(name: "Hamcrest", targets: ["Hamcrest"]),
    ],
    targets: [
        .target(name: "Hamcrest", dependencies: [], path: "Hamcrest"),
        .testTarget(name: "SwiftHamcrestTests", dependencies: ["Hamcrest"], path: "HamcrestTests"),
    ]
)
