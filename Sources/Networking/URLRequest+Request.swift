import Foundation

extension URLRequest {
	public init(_ request: Request) throws {
		var urlRequest = URLRequest(url: build(request: request).url!)
		urlRequest.httpMethod = request.method.rawValue
		urlRequest.httpBody = request.httpBody
		
		request.headers.forEach { header in
			urlRequest.addValue(header.value, forHTTPHeaderField: header.key)
		}
		
		if let authorization = request.authentication.authorization {
			urlRequest.addValue(authorization, forHTTPHeaderField: "Authorization")
		}

		self = urlRequest
	}
}

fileprivate func build(
	request: Request
) -> URLComponents {
	var components = URLComponents()
	components.scheme = request.scheme.rawValue
	components.host = request.host
	components.port = request.port
	components.path = request.uri
	if !request.parameters.isEmpty {
		components.queryItems = request.parameters
	}
	return components
}
