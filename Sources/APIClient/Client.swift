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
	
	public var getSymbols: () async throws -> [String]
	public var getTicker: @Sendable (String) async throws -> AsyncStream<Int>
	
	public var files: @Sendable () async throws -> String
	public var download: @Sendable () async throws -> Data
	
	public init(
		getAcronyms: @escaping () async throws -> [Acronym],
		getAcronym: @escaping (UUID) async throws -> Acronym,
		updateAcronym: @escaping (Acronym) async throws -> Void,
		deleteAcronym: @escaping (Acronym) async throws -> Void,
		searchAcronym: @escaping (Query) async throws -> [Acronym],
		getUsers: @escaping () async throws -> [User],
		getUser: @escaping (UUID) async throws -> User,
		createUser: @escaping (User) async throws -> Void,
		
		getSymbols: @escaping () async throws -> [String],
		getTicker: @escaping @Sendable (String) async throws -> AsyncStream<Int>,
		
		files: @escaping @Sendable () async throws -> String,
		download: @escaping @Sendable () async throws -> Data
	) {
		self.getAcronyms = getAcronyms
		self.getAcronym = getAcronym
		self.updateAcronym = updateAcronym
		self.deleteAcronym = deleteAcronym
		self.searchAcronym = searchAcronym
		self.getUsers = getUsers
		self.getUser = getUser
		self.createUser = createUser
		
		self.getSymbols = getSymbols
		self.getTicker = getTicker
		
		self.files = files
		self.download = download
	}
}

public struct Stock: Hashable, Codable {
  let name: String
  let value: Double
}

import Networking

extension Stock: Mappable {
	public static func map(_ response: APIResponse) -> Self {
		Stock(name: response.name, value: response.value)
	}
	
	public struct APIResponse: Decodable {
		let name: String
		let value: Double
	}
}
