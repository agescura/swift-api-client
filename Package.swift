// swift-tools-version: 5.8

import PackageDescription

let package = Package(
	name: "Swift-API-Client",
	platforms: [.iOS(.v13)],
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
	],
	dependencies: [],
	targets: [
		.target(
			name: "APIClient",
			dependencies: [
				"Models",
				"Networking"
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
		.testTarget(
			name: "NetworkingTests",
			dependencies: ["Networking"]
		),
	]
)
