import Foundation

public struct Parameter {
	let name: String
	let value: String
	
	public init(
		_ name: String,
		value: String
	) {
		self.name = name
		self.value = value
	}
}
