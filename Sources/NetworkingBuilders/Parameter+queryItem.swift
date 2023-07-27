import Foundation

extension Parameter {
	var queryItem: URLQueryItem {
		URLQueryItem(name: self.name, value: self.value)
	}
}
