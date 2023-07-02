import Foundation

public struct Acronym: Codable, Identifiable, Hashable {
	public let id: UUID
	public var short: String
	public var long: String
	
	public init(
		id: UUID?,
		short: String,
		long: String
	) {
		self.id = id ?? UUID()
		self.short = short
		self.long = long
	}
}
