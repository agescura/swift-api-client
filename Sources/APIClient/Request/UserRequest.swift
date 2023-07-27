import Foundation
import Models
import Networking
import NetworkingBuilders

struct UsersRequest {
	@RequestBuilder
	static var users: Request {
		baseRequest
		Uri("/users")
	}
	
	@RequestBuilder
	static func user(_ id: UUID) -> Request {
		users
		Uri("/\(id.uuidString)")
	}
	
	@RequestBuilder
	static func create(_ user: User) -> Request {
		users
		Uri("/\(user.id.uuidString)")
		Method(.post)
		Body(user)
	}
}
