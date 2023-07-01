import Foundation

extension URLSession {
	public func data<Element: Decodable, Model: Mappeable>(
		for request: Request,
		using model: Model.Type,
		decoder: JSONDecoder = JSONDecoder()
	) async throws -> Model where Element == Model.Element {
		let (data, _) = try await self.data(
			for: URLRequest(request)
		)
		let element = try decoder.decode(Element.self, from: data)
		return model.map(element)
	}
}

//extension URLSession {
//	 @available(iOS, deprecated: 15.0, message: "This extension is no longer necessary. Use API built into SDK")
//	 func data(from url: URL) async throws -> (Data, URLResponse) {
//		  try await withCheckedThrowingContinuation { continuation in
//				let task = self.dataTask(with: url) { data, response, error in
//					 guard let data = data, let response = response else {
//						  let error = error ?? URLError(.badServerResponse)
//						  return continuation.resume(throwing: error)
//					 }
//					 
//					 continuation.resume(returning: (data, response))
//				}
//				
//				task.resume()
//		  }
//	 }
//}
