import Foundation

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

extension Header {
	public enum Application: String {
		case xml = "application/xml"
		case json = "application/json"
	}
}

extension Header {
	public static func authorization(value: String) -> Header {
		Header(key: "Authorization", value: value)
	}
	
	public static func authorization(username: String, password: String) -> Header {
		let credentials = Data("\(username):\(password)".utf8).base64EncodedString()
		return .authorization(value: "Basic \(credentials)")
	}
	
	public static func authorization(bearer token: String) -> Header {
		.authorization(value: "Bearer \(token)")
	}
}

extension Header {
	public static func contentType(value: String) -> Header {
		Header(key: "Content-Type", value: value)
	}
	
	public static func contentType(_ application: Header.Application) -> Header {
		.contentType(value: application.rawValue)
	}
}

extension Header {
	public static func accept(value: String) -> Header {
		Header(key: "Accept", value: value)
	}
	
	public static func accept(_ application: Header.Application) -> Header {
		.accept(value: application.rawValue)
	}
}

extension Header {
	public static func userAgent(value: String) -> Header {
		Header(key: "User-Agent", value: value)
	}
}

extension Header {
	public static func acceptEncoding(value: String) -> Header {
		Header(key: "Accept-Encoding", value: value)
	}
}

extension Header {
	public static func acceptLanguage(value: String) -> Header {
		Header(key: "Accept-Language", value: value)
	}
}

extension Header {
	public static func cacheControl(value: String) -> Header {
		Header(key: "Cache-Control", value: value)
	}
}

extension Header {
	public static func ifModifiedSince(value: String) -> Header {
		Header(key: "If-Modified-Since", value: value)
	}
}

extension Header {
	public static func ifMatch(value: String) -> Header {
		Header(key: "If-Match", value: value)
	}
}

extension Header {
	public static func ifNoneMatch(value: String) -> Header {
		Header(key: "If-None-Match", value: value)
	}
}

extension Header {
	public static func connnection(value: String) -> Header {
		Header(key: "Connection", value: value)
	}
}
