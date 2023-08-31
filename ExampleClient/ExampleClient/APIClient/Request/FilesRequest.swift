import Foundation
import Networking
import NetworkingBuilders

struct FilesRequest {
	@RequestBuilder
	static var status: Request {
		Scheme(.http)
		Host("localhost")
		Port(8080)
		Uri("/files/status")
		Method(.get)
	}
	
	@RequestBuilder
	static var download: Request {
		Scheme(.http)
		Host("localhost")
		Port(8080)
		Uri("/files/download")
		Method(.get)
		Parameter("graphics-project-ver-1.jpeg")
	}
	
	@RequestBuilder
	static var chat: Request {
		Scheme(.http)
		Host("localhost")
		Port(8080)
		Uri("/chat/room")
		Method(.get)
		Parameter("Albert".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
	}
}
