// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SkeletonUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "SkeletonUI",
            targets: ["SkeletonUI"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SkeletonUI",
            dependencies: [],
            path: "Sources/SkeletonUI"),
        .testTarget(
            name: "SkeletonUITests",
            dependencies: ["SkeletonUI"],
            path: "Tests/SkeletonUITests"),
    ]
)
