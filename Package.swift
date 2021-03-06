// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "AWSSDKSwiftCore",
    targets: [
        Target(name: "AWSSDKSwiftCore")
    ],
    dependencies: [
        .Package(url: "https://github.com/bytethenoodle/Prorsum.git", majorVersion: 0, minor: 1),
        .Package(url: "https://github.com/bytethenoodle/HypertextApplicationLanguage.git", majorVersion: 1)
    ]
)
