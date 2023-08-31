import Foundation
import Networking

extension User: Mappable {
	public static func map(_ response: APIResponse) -> Self {
		User(
			id: UUID(uuidString: response.id),
			name: response.name,
			username: response.username
		)
	}
	
	public struct APIResponse: Decodable {
		let id: String
		let name: String
		let username: String
	}
}
