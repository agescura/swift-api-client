import Foundation
import Models

public struct APIClient {
	public var getAcronyms: () async throws -> [Acronym]
	public var getAcronym: (UUID) async throws -> Acronym
	public var updateAcronym: (Acronym) async throws -> Void
	public var deleteAcronym: (Acronym) async throws -> Void
	
	public init(
		getAcronyms: @escaping () async throws -> [Acronym],
		getAcronym: @escaping (UUID) async throws -> Acronym,
		updateAcronym: @escaping (Acronym) async throws -> Void,
		deleteAcronym: @escaping (Acronym) async throws -> Void
	) {
		self.getAcronyms = getAcronyms
		self.getAcronym = getAcronym
		self.updateAcronym = updateAcronym
		self.deleteAcronym = deleteAcronym
	}
}
