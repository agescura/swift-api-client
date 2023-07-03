import Foundation

struct APIErrorPayload: Decodable {
	let errors: [String: [String]]
}

enum ApiError<APIErrorPayload: Decodable>: Error {
	case code(Int)
	case service(APIErrorPayload, HTTPURLResponse)
	case http(Data, HTTPURLResponse)
}

extension URLSession {
	public func data<Element: Decodable, Model: Mappable>(
		for request: Request,
		using model: Model.Type,
		decoder: JSONDecoder = JSONDecoder()
	) async throws -> Model where Element == Model.T {
		let (data, response) = try await self.data(
			for: URLRequest(request)
		)
		guard let response = response as? HTTPURLResponse else {
			throw URLError(.badServerResponse)
		}
		switch response.statusCode {
			case 200..<300:
				let element = try decoder.decode(Element.self, from: data)
				return model.map(element)
				
			case 400..<500:
				if let payload = try? decoder.decode(APIErrorPayload.self, from: data) {
					throw ApiError.service(payload, response)
				} else {
					throw ApiError<APIErrorPayload>.code(response.statusCode)
				}
				
			default:
				throw ApiError<APIErrorPayload>.http(data, response)
		}
		
	}
}

extension URLSession {
	public func data(
		for request: Request
	) async throws -> Void {
		let (data, _) = try await self.data(
			for: URLRequest(request)
		)
		print(String(decoding: data, as: UTF8.self))
	}
}
