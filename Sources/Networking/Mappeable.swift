public protocol Mappeable {
	associatedtype Element: Decodable
	
	static func map(_ response: Element) -> Self
}
