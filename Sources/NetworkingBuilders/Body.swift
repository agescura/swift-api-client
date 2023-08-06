import Foundation

public struct Body<T: Encodable> {
	let value: T
	let encoder: JSONEncoder
	
	public init(
		_ value: T,
		encoder: JSONEncoder = JSONEncoder()
	) {
		self.value = value
		self.encoder = encoder
	}
}

extension Body {
	var data: Data? {
		try? encoder.encode(self.value)
	}
}
