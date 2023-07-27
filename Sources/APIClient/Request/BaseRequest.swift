import Foundation
import Networking
import NetworkingBuilders

@RequestBuilder
var baseRequest: Request {
	Scheme(.http)
	Host("localhost")
	Port(8080)
	Uri("/api")
	Method(.get)
}
