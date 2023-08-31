// swift-tools-version: 5.7

import PackageDescription

let package = Package(
	name: "Swift-Api-Client",
	platforms: [.iOS(.v15)],
	products: [
		.library(
			name: "Networking",
			targets: ["Networking"]
		),
		.library(
			name: "NetworkingBuilders",
			targets: ["NetworkingBuilders"]
		),
	],
	dependencies: [],
	targets: [
		.target(
			name: "Networking",
			dependencies: []
		),
		.target(
			name: "NetworkingBuilders",
			dependencies: ["Networking"]
		),
		.testTarget(
			name: "NetworkingTests",
			dependencies: ["Networking"]
		),
	]
)
