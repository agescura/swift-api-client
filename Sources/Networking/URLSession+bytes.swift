import Foundation

@available(iOS 15, *)
extension URLSession {
	public func bytes(
		for request: Request
	) async throws -> URLSession.AsyncBytes {
		let (stream, response) = try await self.bytes(request: request)
		switch response.statusCode {
			case 200..<300:
				return stream
			default:
				throw NetworkError.http(data: Data(), response: response)
		}
	}
}

@available(iOS 15, *)
extension URLSession {
	func bytes(
		request: Request
	) async throws -> (URLSession.AsyncBytes, HTTPURLResponse) {
		let (data, response) = try await self.bytes(
			for: URLRequest(request)
		)
		guard let response = response as? HTTPURLResponse else {
			throw URLError(.badServerResponse)
		}
		return (data, response)
	}
}
