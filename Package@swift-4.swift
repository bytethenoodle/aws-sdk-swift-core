// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "AWSSDKSwiftCore",
    products: [
        .library(name: "AWSSDKSwiftCore", targets: ["AWSSDKSwiftCore"])
    ],
    dependencies: [
        .package(url: "https://github.com/bytethenoodle/Prorsum.git", .upToNextMajor(from: "0.1.16")),
        .package(url: "https://github.com/bytethenoodle/HypertextApplicationLanguage.git", .upToNextMajor(from: "1.0.1"))
    ],
    targets: [
        .target(name: "AWSSDKSwiftCore", dependencies: ["Prorsum", "HypertextApplicationLanguage"]),
        .testTarget(name: "AWSSDKSwiftCoreTests", dependencies: ["AWSSDKSwiftCore"])
    ]
)
