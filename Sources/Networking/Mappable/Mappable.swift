public protocol Mappable {
	associatedtype T: Decodable
	
	static func map(_ response: T) -> Self
}

extension Array: Mappable where Element: Mappable {
	public static func map(_ response: [Element.T]) -> Array<Element> {
		response.compactMap(Element.map)
	}
}
