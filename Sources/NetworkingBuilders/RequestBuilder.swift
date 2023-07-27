import Foundation
import Networking

public struct Scheme {
	let value: HTTPScheme
	
	public init(
		_ value: HTTPScheme
	) {
		self.value = value
	}
}

public struct Host {
	let value: String
	
	public init(
		_ value: String
	) {
		self.value = value
	}
}

public struct Port {
	let value: Int
	
	public init(
		_ value: Int
	) {
		self.value = value
	}
}

public struct Uri {
	let value: String
	
	public init(
		_ value: String
	) {
		self.value = value
	}
}

public struct Method {
	let value: HTTPMethod
	
	public init(
		_ value: HTTPMethod
	) {
		self.value = value
	}
}

public struct Parameter {
	let name: String
	let value: String
	
	public init(
		_ name: String,
		value: String
	) {
		self.name = name
		self.value = value
	}
}

extension Parameter {
	var queryItem: URLQueryItem {
		URLQueryItem(name: self.name, value: self.value)
	}
}

public struct Header {
	let key: String
	let value: String
	
	public init(
		key: String,
		value: String
	) {
		self.key = key
		self.value = value
	}
}

public struct Body<T: Encodable> {
	let value: T
	let encoder: JSONEncoder
	
	public init(
		_ value: T,
		encoder: JSONEncoder = JSONEncoder()
	) {
		self.value = value
		self.encoder = encoder
	}
}

extension Body {
	var data: Data? {
		try? encoder.encode(self.value)
	}
}

@resultBuilder
public struct RequestBuilder {
	static public func buildBlock(
		_ scheme: Scheme,
		_ host: Host,
		_ port: Port,
		_ uri: Uri,
		_ method: Method
	) -> Request {
		Request(
			scheme: scheme.value,
			host: host.value,
			port: port.value,
			uri: uri.value,
			parameters: [],
			method: method.value,
			headers: [:],
			authentication: .none
		)
	}
	
	static public func buildBlock(
		_ request: Request,
		_ uri: Uri
	) -> Request {
		Request(
			scheme: request.scheme,
			host: request.host,
			port: request.port,
			uri: request.uri + uri.value,
			parameters: [],
			method: request.method,
			headers: [:],
			authentication: .none
		)
	}
	
	static public func buildBlock(
		_ request: Request,
		_ uri: Uri,
		_ method: Method
	) -> Request {
		Request(
			scheme: request.scheme,
			host: request.host,
			port: request.port,
			uri: request.uri + uri.value,
			parameters: [],
			method: method.value,
			headers: [:],
			authentication: .none
		)
	}
	
	static public func buildBlock<T: Encodable>(
		_ request: Request,
		_ uri: Uri,
		_ method: Method,
		_ body: Body<T>
	) -> Request {
		Request(
			scheme: request.scheme,
			host: request.host,
			port: request.port,
			uri: request.uri + uri.value,
			parameters: [],
			method: method.value,
			httpBody: body.data,
			headers: [:],
			authentication: .none
		)
	}
	
	static public func buildBlock(
		_ request: Request,
		_ parameters: Parameter...
	) -> Request {
		Request(
			scheme: request.scheme,
			host: request.host,
			port: request.port,
			uri: request.uri,
			parameters: parameters.map { $0.queryItem },
			method: request.method,
			headers: [:],
			authentication: .none
		)
	}
}
