import Foundation

extension Body {
	var data: Data? {
		try? encoder.encode(self.value)
	}
}
