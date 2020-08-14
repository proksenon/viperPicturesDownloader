import UIKit

final class ImageResizer: ImageResizerProtocol {
	/// Ресайз картинки
	func imageToSize(size: CGSize?, data: Data?) ->Data? {
		if let data = data, let size = size {
			if let image = UIImage(data: data) {
				let newImage = image.resizeImage(targetSize: size)
				let newData = newImage?.pngData()
				return newData
			}
		}
		return nil
	}
}
