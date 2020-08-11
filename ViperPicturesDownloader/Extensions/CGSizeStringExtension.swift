import UIKit
/// Превращает CGSize в String
extension CGSize {
	func toString()->String? {
		return "\(self.width)x\(self.height)"
	}
}
