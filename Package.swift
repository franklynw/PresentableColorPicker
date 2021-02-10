// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PresentableColorPicker",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "PresentableColorPicker",
            targets: ["PresentableColorPicker"]),
    ],
    dependencies: [
        .package(name: "HalfASheet", url: "https://github.com/franklynw/HalfASheet.git", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "PresentableColorPicker",
            dependencies: ["HalfASheet"],
            resources: [.process("Resources")]),
        .testTarget(
            name: "PresentableColorPickerTests",
            dependencies: ["PresentableColorPicker"]),
    ]
)
