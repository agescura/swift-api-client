import Foundation

public struct Header {
	let key: String
	let value: String
	
	public init(
		key: String,
		value: String
	) {
		self.key = key
		self.value = value
	}
}