import Foundation
import Models
import Networking

extension APIClient {
	public static var liveValue: Self = {
		let session = URLSession.shared
		
		return Self(
			getAcronyms: {
				try await session.data(for: AcronymsRequest.acronyms, using: [Acronym].self)
			},
			getAcronym: { id in
				try await session.data(for: AcronymsRequest.acronym(id), using: Acronym.self)
			},
			updateAcronym: { acronym in
				try await session.data(for: AcronymsRequest.update(acronym))
			},
			deleteAcronym: { acronym in
				try await session.data(for: AcronymsRequest.delete(acronym))
			}
		)
	}()
}

enum AcronymsRequest {
	case acronyms
	case acronym(UUID)
	case update(Acronym)
	case delete(Acronym)
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
		}
	}
	
	var parameters: [URLQueryItem] {
		[]
	}
	
	var method: HTTPMethod {
		switch self {
			case .acronym, .acronyms:
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
				case .acronym, .acronyms, .delete:
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
