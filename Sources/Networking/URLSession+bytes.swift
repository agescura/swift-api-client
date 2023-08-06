import Foundation

@available(iOS 15, *)
extension URLSession {
	public func bytes<Element: Decodable, Model: Mappable>(
		for request: Request,
		using model: Model.Type,
		decoder: JSONDecoder = JSONDecoder()
	) async throws -> AsyncStream<Model> where Element == Model.T {
		fatalError()
//		let (stream, response) = try! await self.bytes(request: request)
//		switch response.statusCode {
//			case 200..<300:
//				for try await line in stream.lines {
//					let element = try decoder.decode(Element.self, from: Data(line.utf8))
//					print(model.map(element))
//				}
//			default:
//				fatalError()
//				//					throw NetworkError.http(data: Data(), response: response)
//		}
	}
}

@available(iOS 15, *)
extension URLSession {
	func bytes(
		request: Request
	) async throws -> (URLSession.AsyncBytes, HTTPURLResponse) {
		let (data, response) =
		
		try await self.bytes(
			for: URLRequest(request)
		)
		guard let response = response as? HTTPURLResponse else {
			throw URLError(.badServerResponse)
		}
		return (data, response)
	}
}
