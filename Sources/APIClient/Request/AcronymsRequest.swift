import Foundation
import Models
import Networking
import NetworkingBuilders

struct AcronymsRequest {
	@RequestBuilder
	static var acronyms: Request {
		baseRequest
		Uri("/acronyms")
	}

	@RequestBuilder
	static func acronym(_ id: UUID) -> Request {
		acronyms
		Uri("/\(id.uuidString)")
	}

	@RequestBuilder
	static func update(_ acronym: Acronym) -> Request {
		acronyms
		Uri("/\(acronym.id.uuidString)")
		Method(.put)
		Body(acronym)
	}
	
	@RequestBuilder
	static func delete(_ acronym: Acronym) -> Request {
		acronyms
		Uri("/\(acronym.id.uuidString)")
		Method(.delete)
	}
	
	@RequestBuilder
	static func search(_ query: Query) -> Request {
		acronyms
		Parameter("term", value: query)
	}
}
