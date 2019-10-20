// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Logr",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(name: "Logr", targets: ["Logr"])
    ],
    targets: [
        .target(name: "Logr",
                path: ".",
                sources: ["Sources"]),
        .testTarget(name: "LogrTests",
                    dependencies: ["Logr"],
                    path: ".",
                    sources: ["Tests"])
    ]
)
