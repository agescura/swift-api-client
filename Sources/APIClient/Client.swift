import Foundation
import Models

public struct APIClient {
	public var acronyms: () async throws -> [Acronym]
	public var acronym: (UUID) async throws -> Acronym
	public var updateAcronym: (Acronym) async throws -> Acronym
	
	public init(
		acronyms: @escaping () async throws -> [Acronym],
		acronym: @escaping (UUID) async throws -> Acronym,
		updateAcronym: @escaping (Acronym) async throws -> Acronym
	) {
		self.acronyms = acronyms
		self.acronym = acronym
		self.updateAcronym = updateAcronym
	}
}
