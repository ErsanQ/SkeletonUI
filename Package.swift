// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SkeletonUI",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SkeletonUI",
            targets: ["SkeletonUI"]
        ),
    ],
    targets: [
        .target(
            name: "SkeletonUI",
            path: "Sources/SkeletonUI",
            swiftSettings: [
                .enableExperimentalFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "SkeletonUITests",
            dependencies: ["SkeletonUI"],
            path: "Tests/SkeletonUITests"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
