import Foundation
import Models
import Networking

extension APIClient {
	public static var liveValue: Self = {
		let session = URLSession.shared
		
		return Self(
			fruit: { name in
				try await session.data(for: FruitRequest.fruit(name), using: Fruit.self)
			}
		)
	}()
}

enum FruitRequest {
	case fruit(String)
}

extension FruitRequest: Request {
	var scheme: HTTPScheme {
		.https
	}
	
	var baseUrl: String {
		"www.fruityvice.com"
	}
	
	var path: String {
		"/api/fruit/banana"
	}
	
	var parameters: [URLQueryItem] {
		[]
	}
	
	var method: HTTPMethod {
		.get
	}
	
	var httpBody: Data? {
		nil
	}
	
	var headers: [String : String] {
		[:]
	}
	
	var authentication: Bool {
		false
	}
}
