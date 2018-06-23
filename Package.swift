// swift-tools-version:4.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// !!!: Use `swift build` from the cli to get a static binary.
//      Building from xcode does not produce the static binary

let package = Package(
    name: "xchelper",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/saltzmanjoelh/XcodeHelperCliKit.git", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "xchelper",
            dependencies: ["XcodeHelperCliKit"]),
    ]
)
