import Foundation

extension URLSession {
	public func data<Element: Decodable, Model: Mappable>(
		for request: Request,
		using model: Model.Type,
		decoder: JSONDecoder = JSONDecoder()
	) async throws -> Model where Element == Model.T {
		let (data, response) = try await self.data(request: request)
		
		switch response.statusCode {
			case 200..<300:
				let element = try decoder.decode(Element.self, from: data)
				return model.map(element)
			default:
				throw NetworkError.http(data: data, response: response)
		}
	}
}

extension URLSession {
	@discardableResult
	public func data(
		for request: Request
	) async throws -> Data {
		let (data, response) = try await self.data(request: request)
		switch response.statusCode {
			case 200..<300:
				return data
			default:
				throw NetworkError.http(data: data, response: response)
		}
	}
}

extension URLSession {
	func data(
		request: Request
	) async throws -> (Data, HTTPURLResponse) {
		let (data, response) =
		
		try await self.data(
			for: URLRequest(request)
		)
		guard let response = response as? HTTPURLResponse else {
			throw URLError(.badServerResponse)
		}
		return (data, response)
	}
}

