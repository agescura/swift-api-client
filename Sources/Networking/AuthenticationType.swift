import Foundation

public enum Authentication {
	case none
	case basic(username: String, password: String)
}

extension Authentication {
	var authorization: String? {
		if case let .basic(username, password) = self {
			return "Basic \((username + ":" + password).data(using: .utf8)!.base64EncodedString())"
		}
		return nil
	}
}
