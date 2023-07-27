import Foundation
import Networking

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
