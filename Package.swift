// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DIDMotif",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DIDMotif",
            targets: ["did-motif-ios"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
//        .package(url: "https://github.com/ArcBlock/BaseEncoding-swift.git", from: "0.0.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "did-motif-ios",
            dependencies: []),
        .testTarget(
            name: "did-motif-iosTests",
            dependencies: ["did-motif-ios"]),
    ]
)
