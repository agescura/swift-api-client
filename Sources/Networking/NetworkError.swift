import Foundation

public enum NetworkError: Error {
	case http(data: Data, response: HTTPURLResponse)
}
