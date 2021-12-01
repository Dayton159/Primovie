// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Explore",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Explore",
            targets: ["Explore"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
      .package(name: "Primovie-Core", url: "https://github.com/Dayton159/Primovie-Core.git", from: "1.0.1"),
      .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.2.0"),
      .package(path: "../Common")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Explore",
            dependencies: [
              "Primovie-Core",
              "RxSwift",
              .product(name: "RxCocoa", package: "RxSwift"),
              "Common"
            ]),
        .testTarget(
            name: "ExploreTests",
            dependencies: ["Explore"])
    ]
)
