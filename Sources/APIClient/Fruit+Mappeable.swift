import Models
import Networking

extension Fruit: Mappeable {
	public static func map(_ response: APIFruit) -> Fruit {
		Fruit(
			id: response.id,
			name: response.name,
			family: response.family,
			order: response.order,
			genus: response.genus
		)
	}
	
	public struct APIFruit: Decodable {
		let id: Int
		let name: String
		let family: String
		let order: String
		let genus: String
	}
}
