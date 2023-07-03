import Foundation
import Models
import Networking

extension Acronym: Mappable {
	public static func map(_ response: APIResponse) -> Self {
		Acronym(
			id: UUID(uuidString: response.id),
			short: response.short,
			long: response.long
		)
	}
	
	public struct APIResponse: Decodable {
		let id: String
		let short: String
		let long: String
	}
}
