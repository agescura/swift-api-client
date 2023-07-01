// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "Swift-API-Client",
    products: [
        .library(
            name: "MyLibrary",
            targets: ["MyLibrary"]
		  ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MyLibrary",
            dependencies: []
		  ),
        .testTarget(
            name: "MyLibraryTests",
            dependencies: ["MyLibrary"]
		  ),
    ]
)
