import Foundation

public struct Request {
	public var scheme: HTTPScheme
	public var host: String
	public var port: Int?
	public var uri: String
	public var parameters: [URLQueryItem]
	public var method: HTTPMethod
	public var httpBody: Data?
	public var headers: [String: String]
	public var authentication: Authentication
	public var decoder: JSONDecoder
	
	public init(
		scheme: HTTPScheme,
		host: String,
		port: Int? = nil,
		uri: String,
		parameters: [URLQueryItem],
		method: HTTPMethod,
		httpBody: Data? = nil,
		headers: [String : String],
		authentication: Authentication,
		decoder: JSONDecoder = JSONDecoder()
	) {
		self.scheme = scheme
		self.host = host
		self.port = port
		self.uri = uri
		self.parameters = parameters
		self.method = method
		self.httpBody = httpBody
		self.headers = headers
		self.authentication = authentication
		self.decoder = decoder
	}
}

