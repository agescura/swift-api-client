import Foundation
import Models

public struct APIClient {
	public var fruit: (String) async throws -> Fruit
	
	public init(
		fruit: @escaping (String) async throws -> Fruit
	) {
		self.fruit = fruit
	}
}
