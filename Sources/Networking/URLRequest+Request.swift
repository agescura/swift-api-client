import Foundation

extension URLRequest {
	public init(_ request: Request) throws {
		var urlRequest = URLRequest(url: build(request: request).url!)
		urlRequest.httpMethod = request.method.rawValue
		urlRequest.httpBody = try request.httpBody
		
		_ = request.headers.map {
			urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
		}
		
		self = urlRequest
	}
}

fileprivate func build(
	request: Request
) -> URLComponents {
	var components = URLComponents()
	components.scheme = request.scheme.rawValue
	components.host = request.baseUrl
	components.port = request.port
	components.path = request.path
	if !request.parameters.isEmpty {
		components.queryItems = request.parameters
	}
	return components
}
