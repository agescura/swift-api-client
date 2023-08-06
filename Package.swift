// swift-tools-version: 5.7

import PackageDescription

let package = Package(
	name: "Swift-API-Client",
	platforms: [.iOS(.v15)],
	products: [
		.library(
			name: "APIClient",
			targets: ["APIClient"]
		),
		.library(
			name: "Models",
			targets: ["Models"]
		),
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
			name: "APIClient",
			dependencies: [
				"Models",
				"Networking",
				"NetworkingBuilders"
			]
		),
		.target(
			name: "Models",
			dependencies: []
		),
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
