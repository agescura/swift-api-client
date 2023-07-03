import Foundation

public struct User: Identifiable, Equatable, Hashable, Codable {
	public let id: UUID
	public var name: String
	public var username: String
	
	public init(
		id: UUID? = nil,
		name: String,
		username: String
	) {
		self.id = id ?? UUID()
		self.name = name
		self.username = username
	}
}
