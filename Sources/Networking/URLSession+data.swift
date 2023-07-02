import Foundation

extension URLSession {
	public func data<Element: Decodable, Model: Mappeable>(
		for request: Request,
		using model: Model.Type,
		decoder: JSONDecoder = JSONDecoder()
	) async throws -> Model where Element == Model.T {
		let (data, _) = try await self.data(
			for: URLRequest(request)
		)
		let element = try decoder.decode(Element.self, from: data)
		return model.map(element)
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
