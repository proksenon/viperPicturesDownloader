import UIKit

protocol ImageResizerProtocol {
	///  Приниает дату картинки, делает ресайз и возращает дату
	func imageToSize(size: CGSize?, data: Data?) ->Data?
}
