import Foundation

public struct Fruit {
	public let id: Int
	public let name: String
	public let family: String
	public let order: String
	public let genus: String
	
	public init(
		id: Int,
		name: String,
		family: String,
		order: String,
		genus: String
	) {
		self.id = id
		self.name = name
		self.family = family
		self.order = order
		self.genus = genus
	}
}
