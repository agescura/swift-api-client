import Foundation
import Models
import Networking

extension APIClient {
	public static var liveValue: Self = {
		let session = URLSession.shared
		
		return Self(
			getAcronyms: {
				do {
					return try await session.data(for: AcronymsRequest.acronyms, using: [Acronym].self)
				} catch {
					print(error)
					return []
				}
			},
			getAcronym: { id in
				try await session.data(for: AcronymsRequest.acronym(id), using: Acronym.self)
			},
			updateAcronym: { acronym in
				try await session.data(for: AcronymsRequest.update(acronym))
			},
			deleteAcronym: { acronym in
				try await session.data(for: AcronymsRequest.delete(acronym))
			},
			searchAcronym: { query in
				try await session.data(for: AcronymsRequest.search(query), using: [Acronym].self)
			},
			getUsers: {
				do {
					return try await session.data(for: UsersRequest.users, using: [User].self)
				} catch {
					if case let NetworkError.http(data: data, response: response) = error {
						print(data)
						print(response)
						print(response.statusCode)
					}
					print(error)
					return []
				}
			},
			getUser: { id in
				try await session.data(for: UsersRequest.user(id), using: User.self)
			},
			createUser: { user in
				try await session.data(for: UsersRequest.createUser(user))
			}
		)
	}()
}

enum UsersRequest {
	case users
	case user(UUID)
	case createUser(User)
}

extension UsersRequest: Request {
	var scheme: HTTPScheme {
		.http
	}
	
	var baseUrl: String {
		"localhost"
	}
	
	var port: Int? {
		8080
	}
	
	var path: String {
		switch self {
			case .users, .createUser:
				return "/api/users"
			case let .user(id):
				return "/api/users/\(id.uuidString)"
		}
	}
	
	var parameters: [URLQueryItem] {
		return []
	}
	
	var method: HTTPMethod {
		switch self {
			case .users, .user:
				return .get
			case .createUser:
				return .post
		}
	}
	
	var httpBody: Data? {
		get throws {
			switch self {
				case .users, .user:
					return nil
				case let .createUser(user):
					return try JSONEncoder().encode(user)
			}
		}
	}
	
	var headers: [String : String] {
		["Content-Type": "application/json"]
	}
}

enum AcronymsRequest {
	case acronyms
	case acronym(UUID)
	case update(Acronym)
	case delete(Acronym)
	case search(Query)
}

extension AcronymsRequest: Request {
	var scheme: HTTPScheme {
		.http
	}
	
	var baseUrl: String {
		"localhost"
	}
	
	var port: Int? {
		8080
	}
	
	var path: String {
		switch self {
			case .acronyms:
				return "/api/acronyms"
			case let .acronym(id):
				return "/api/acronyms/\(id.uuidString)"
			case let .update(acronym), let .delete(acronym):
				return "/api/acronyms/\(acronym.id.uuidString)"
			case .search:
				return "/api/acronyms/search"
		}
	}
	
	var parameters: [URLQueryItem] {
		switch self {
			case .acronym, .acronyms, .delete, .update:
				return []
			case let .search(query):
				return [
					URLQueryItem(name: "term", value: query)
				]
		}
	}
	
	var method: HTTPMethod {
		switch self {
			case .acronym, .acronyms, .search:
				return .get
			case .update:
				return .put
			case .delete:
				return .delete
		}
	}
	
	var httpBody: Data? {
		get throws {
			switch self {
				case .acronym, .acronyms, .delete, .search:
					return nil
				case let .update(acronym):
					return try JSONEncoder().encode(acronym)
			}
		}
	}
	
	var headers: [String : String] {
		["Content-Type": "application/json"]
	}
}
