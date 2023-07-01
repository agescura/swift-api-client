import Foundation

public protocol Request {
	var scheme: HTTPScheme { get }
	var baseUrl: String { get }
	var path: String { get }
	var parameters: [URLQueryItem] { get }
	var method: HTTPMethod { get }
	var httpBody: Data? { get }
	var headers: [String: String] { get }
}
