// swift-tools-version:5.8

import PackageDescription

let package = Package(
    name: "UserDefaultsUI",
    platforms: [
        .iOS(.v15), .macOS(.v12), .tvOS(.v15)
    ],
    products: [
        .library(name: "UserDefaultsUI", targets: ["UserDefaultsUI"])
    ],
    targets: [
        .target(
            name: "UserDefaultsUI",
            dependencies: [],
            swiftSettings: [
                .define("DEBUG", .when(configuration: .debug)),
                .define("RELEASE", .when(configuration: .release)),
                .define("SWIFT_PACKAGE")
            ])
    ]
)
