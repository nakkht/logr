// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "Logr",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "Logr",
                 targets: ["Logr"])
    ],
    targets: [
        .target(name: "Logr"),
        .testTarget(name: "LogrTests",
                    dependencies: ["Logr"])
    ],
    swiftLanguageVersions: [.v5]
)
