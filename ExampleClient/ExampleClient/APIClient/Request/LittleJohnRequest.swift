import Foundation
import Networking
import NetworkingBuilders

struct LittleJohnRequest {
	@RequestBuilder
	static var littlejohn: Request {
		Scheme(.http)
		Host("localhost")
		Port(8080)
		Uri("/littlejohn")
		Method(.get)
	}
	
	@RequestBuilder
	static var symbols: Request {
		littlejohn
		Uri("/symbols")
	}
	
	@RequestBuilder
	static func ticker(symbol: String) -> Request {
		littlejohn
		Uri("/ticker")
		Parameter(symbol)
	}
}
