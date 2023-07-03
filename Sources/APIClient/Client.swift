import Foundation
import Models

public typealias Query = String

public struct APIClient {
	public var getAcronyms: () async throws -> [Acronym]
	public var getAcronym: (UUID) async throws -> Acronym
	public var updateAcronym: (Acronym) async throws -> Void
	public var deleteAcronym: (Acronym) async throws -> Void
	public var searchAcronym: (Query) async throws -> [Acronym]
	public var getUsers: () async throws -> [User]
	public var getUser: (UUID) async throws -> User
	public var createUser: (User) async throws -> Void
	
	public init(
		getAcronyms: @escaping () async throws -> [Acronym],
		getAcronym: @escaping (UUID) async throws -> Acronym,
		updateAcronym: @escaping (Acronym) async throws -> Void,
		deleteAcronym: @escaping (Acronym) async throws -> Void,
		searchAcronym: @escaping (Query) async throws -> [Acronym],
		getUsers: @escaping () async throws -> [User],
		getUser: @escaping (UUID) async throws -> User,
		createUser: @escaping (User) async throws -> Void
	) {
		self.getAcronyms = getAcronyms
		self.getAcronym = getAcronym
		self.updateAcronym = updateAcronym
		self.deleteAcronym = deleteAcronym
		self.searchAcronym = searchAcronym
		self.getUsers = getUsers
		self.getUser = getUser
		self.createUser = createUser
	}
}
