// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Common",
    platforms: [.iOS(.v14), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Common",
            targets: ["Common"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
      .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.4.4"),
      .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Common",
            dependencies: [
              "RxSwift",
              .product(name: "RxCocoa", package: "RxSwift"),
              "Alamofire"
            ]),
        .testTarget(
            name: "CommonTests",
            dependencies: ["Common"])
    ]
)
