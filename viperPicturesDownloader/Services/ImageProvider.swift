import UIKit

final class ImageProvider: ImageProviderProtocol {
	let networkService: NetworkServiceProtocol
	let fileProvider: FileProviderProtocol
	let imageNameManager: ImageNameManagerProtocol
	let imageResizer: ImageResizerProtocol
	let defaultImage = UIImage(named: "defultImage")
	let encryptionManager = EncryptionManager()

	init(networkService: NetworkServiceProtocol = NetworkService(),
		 fileProvider: FileProviderProtocol = FileProvider(),
		 imageNameManager: ImageNameManagerProtocol = ImageNameManager(),
		 imageResizer: ImageResizerProtocol = ImageResizer()) {
		self.networkService = networkService
		self.fileProvider = fileProvider
		self.imageNameManager = imageNameManager
		self.imageResizer = imageResizer
	}
	
	func loadImage(url: String, size: CGSize?, completion: @escaping (UIImage?) -> Void) {
		let nameFileOrigin = imageNameManager.getNameFileImage(url: url, size: nil)
		if fileProvider.checkDirectory(nameFile: nameFileOrigin) {
			let nameFile = imageNameManager.getNameFileImage(url: url, size: size)
			if fileProvider.checkDirectory(nameFile: nameFile) {
				if let data = fileProvider.readFile(nameFile: nameFile) {
					if let decryptData = encryptionManager.decryptionData(data: data) {
						completion(UIImage(data: decryptData))
					}
				}
			} else {
				originalToSize(url: url, nameFile: nameFile, size: size) { (image) in
					completion(image)
				}
			}
		} else {
			if let currentUrl = URL(string: url) {
				networkService.getData(url: currentUrl) { (data) in
					self.dataToFile(nameFile: nameFileOrigin, data: data)
					let nameFile = self.imageNameManager.getNameFileImage(url: url, size: size)
					self.originalToSize(url: url, nameFile: nameFile, size: size) { (image) in
						completion(image)
					}
				}
			}
		}
	}

	private func dataToFile(nameFile: String, data: Data) {
		let path = self.fileProvider.getPath(nameFile: nameFile, directory: NSTemporaryDirectory())
		if let encryptData = encryptionManager.encryptionData(data: data) {
			self.fileProvider.writeToFile(data: encryptData, path: path)
		}
	}

	private func originalToSize(url: String, nameFile: String, size: CGSize?, completion: @escaping (UIImage?) -> Void) {
		if let data = fileProvider.readFile(nameFile: imageNameManager.getNameFileImage(url: url, size: nil)) {
			if let decryptData = encryptionManager.decryptionData(data: data) {
				if let newData = imageResizer.imageToSize(nameFile: nameFile, size: size, data: decryptData) {
					completion (UIImage(data: newData))
					dataToFile(nameFile: nameFile, data: newData)
				} else {
					completion (UIImage(data: decryptData))
				}
			}
		}
	}

	func loadImages(urls:[String], size: CGSize?, completion: @escaping ([UIImage?]) -> Void) {
		var images: [UIImage?] = []
		var imagesWithUrl: [String:UIImage] = [:]
		let downloadGroup = DispatchGroup()
		
		for url in urls {
			downloadGroup.enter()
			self.loadImage(url: url, size: size) { (image) in
				imagesWithUrl[url] = image
				downloadGroup.leave()
			}
		}
		downloadGroup.notify(queue: DispatchQueue.main) {
			images = self.sortImages(imagesWithUrl: imagesWithUrl, urls: urls)
			completion(images)
		}
	}

	private func sortImages(imagesWithUrl: [String: UIImage], urls: [String])->[UIImage?] {
		var images: [UIImage?] = []
		for url in urls {
			images.append(imagesWithUrl[url])
		}
		return images
	}
}
