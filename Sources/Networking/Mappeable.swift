public protocol Mappeable {
	associatedtype T: Decodable
	
	static func map(_ response: T) -> Self
}

extension Array: Mappeable where Element: Mappeable {
	public typealias ElementDecodable = [Element.T]
	
	public static func map(_ response: [Element.T]) -> Array<Element> {
		response.compactMap(Element.map)
	}
}
