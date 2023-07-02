import Foundation
import Models
import Networking

extension APIClient {
	public static var liveValue: Self = {
		let session = URLSession.shared
		
		return Self(
			acronyms: {
				try await session.data(for: AcronymsRequest.acronyms, using: [Acronym].self)
			},
			acronym: { id in
				try await session.data(for: AcronymsRequest.acronym(id), using: Acronym.self)
			},
			updateAcronym: { acronym in
				try await session.data(for: AcronymsRequest.update(acronym), using: Acronym.self)
			}
		)
	}()
}

enum AcronymsRequest {
	case acronyms
	case acronym(UUID)
	case update(Acronym)
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
			case let .update(acronym):
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
		}
	}
	
	var httpBody: Data? {
		get throws {
			switch self {
				case .acronym, .acronyms:
					return nil
				case let .update(acronym):
					return try JSONEncoder().encode(acronym)
			}
		}
	}
	
	var headers: [String : String] {
		[:]
	}
}
