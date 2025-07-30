// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "xxHash",
    products: [
        .library(
            name: "xxHash",
            targets: ["xxHash", "CxxHash"]
        ),
    ],
    targets: [
        .target(
            name: "xxHash",
            dependencies: ["CxxHash"]
        ),
        .target(
            name: "CxxHash"
        ),
        .testTarget(
            name: "xxHashTests",
            dependencies: ["xxHash"]
        ),
    ]
)
