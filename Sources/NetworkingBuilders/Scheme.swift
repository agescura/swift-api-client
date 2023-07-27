import Foundation
import Networking

public struct Scheme {
	let value: HTTPScheme
	
	public init(
		_ value: HTTPScheme
	) {
		self.value = value
	}
}
