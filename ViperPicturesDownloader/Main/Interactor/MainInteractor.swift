//
//  MainInteractor.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
/// Интерактор главного экрана
final class MainInteractor : MainInteractorInput {

	weak var presenter: MainInteractorOutput?
	var imageUrls: ImageUrls?
	var imageNameManager: ImageNameManagerProtocol?
	var fileProvider: FileProviderProtocol?
	var encryptionManager: EncryptionManagerProtocol?
	var networkService: NetworkServiceProtocol?
	var imageResizer: ImageResizerProtocol?
	var userDefaultsWork: UserDefaultsWorkProtocol?

	init(presenter: MainInteractorOutput,
		 imageNameManager: ImageNameManagerProtocol = ImageNameManager(),
		 fileProvider: FileProviderProtocol = FileProvider(),
		 encryptionManager: EncryptionManagerProtocol = EncryptionManager(),
		 networkService: NetworkServiceProtocol = NetworkService(),
		 imageResizer: ImageResizerProtocol = ImageResizer(),
		 userDefaultsWork: UserDefaultsWorkProtocol = UserDefaultsWork()) {

		self.presenter = presenter
		self.imageNameManager = imageNameManager
		self.fileProvider = fileProvider
		self.encryptionManager = encryptionManager
		self.networkService = networkService
		self.imageResizer = imageResizer
		self.userDefaultsWork = userDefaultsWork
	}

	func getImageUrls() -> ImageUrls? {
		return imageUrls
	}

	func deleteImage(indexPath: IndexPath) {
		guard var imageUrls = imageUrls else { return }
		guard let userDefaultsWork = userDefaultsWork else { return }
		guard let fileProvider = fileProvider else { return }

		let urlDelete = imageUrls.urls[indexPath.row]
		if let imagesSize = userDefaultsWork.getObject(for: urlDelete) as? [String: String] {
			for (_, nameFile) in imagesSize {
				fileProvider.removeFile(nameFile: nameFile, before: nil)
			}
		}
		userDefaultsWork.removeObjects(urls: [urlDelete])
		imageUrls.urls.remove(at: indexPath.row)
		self.imageUrls = imageUrls
		saveImageUrls()
	}

	func didAddUrl(urlString: String?) {
		guard var imageUrls = imageUrls else { return }
		if let url = urlString {
			imageUrls.urls.append(url)
			self.imageUrls = imageUrls
			saveImageUrls()
		}
	}

	func setImageUrls() {
		guard let userDefaultsWork = userDefaultsWork else { return }
		if let imageUrlsFromStorage: ImageUrls = userDefaultsWork.getObjectWithDecoder(for: "imageUrls") {
			imageUrls = imageUrlsFromStorage
		} else {
			imageUrls = ImageUrls()
		}
	}

	func saveImageUrls() {
		guard let userDefaultsWork = userDefaultsWork else { return }
		userDefaultsWork.setObjectWithDecoder(for: "imageUrls", object: imageUrls)
	}
	
	func numberOfRows() -> Int? {
		guard let imageUrls = imageUrls else { return 0}
		return imageUrls.urls.count
	}

	func setImage(imageModel: Image) {

		guard let imageNameManager = imageNameManager else { return }
		guard var imageUrls = imageUrls else { return }
		guard let fileProvider = fileProvider else { return }

		var imageUrlString: String!
		var imageFormat: ImageFormat = .png
		guard let image = imageModel.image else { return }
		if imageModel.urlString == nil {
			imageUrlString = UUID().uuidString
			imageFormat = .jpeg
		} else {
			guard let urlString = imageModel.urlString else { return }
			imageUrlString = urlString
			if imageUrlString.hasSuffix(".jpeg") {
				imageFormat = .jpeg
			}
		}
		guard let data = imageToDataWith(format: imageFormat, image: image) else { return }
		let nameFile = imageNameManager.getNameFileImage(url: imageUrlString, size: nil)
		if !fileProvider.checkDirectory(nameFile: nameFile) {
			dataToFile(nameFile: nameFile, data: data)
			imageUrls.urls.append(imageUrlString)
			self.imageUrls = imageUrls
			saveImageUrls()
		}
		fileProvider.removeFilesWithType()
	}
	
	private func imageToDataWith(format: ImageFormat, image: UIImage)-> Data? {
		switch format {
		case .jpeg:
			return image.jpegData(compressionQuality: 1)
		default:
			return image.pngData()
		}
	}

	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void) {
		guard let imageUrls = imageUrls else { return }
		guard let imageNameManager = imageNameManager else { return }
		guard imageUrls.urls.count >= indexPath.row else {return}
		guard let fileProvider = fileProvider else { return }
		let url = imageUrls.urls[indexPath.row]
		let nameFileOrigin = imageNameManager.getNameFileImage(url: url, size: nil)
		if fileProvider.checkDirectory(nameFile: nameFileOrigin) {
			imageFromCache(url: url, size: size) { (image) in
				completion(image)
			}
		} else {
			if let currentUrl = URL(string: url) {
				downloadImage(currentUrl: currentUrl, url: url, nameFileOrigin: nameFileOrigin, size: size) { (image) in
					if image.image == nil {
						completion(Image(image: UIImage(named: "defaultImage")))
					} else {
						completion(image)
					}
				}
			}
		}
	}
	/// 	Получает картинку с файлов
	private func imageFromCache(url: String, size: ImageSize, completion: @escaping (Image)->Void) {
		guard let imageNameManager = imageNameManager else { return }
		guard let fileProvider = fileProvider else { return }

		let nameFile = imageNameManager.getNameFileImage(url: url, size: size.size)
		if fileProvider.checkDirectory(nameFile: nameFile) {
			if let decryptData = decryptionDataFromFile(url: url, nameFile: nameFile) {
				let image = Image(image: UIImage(data: decryptData))
				completion(image)
			}
		} else {
			originalToSize(url: url, nameFile: nameFile, size: size.size) { (image) in
				completion(Image(image: image))
				}
			}
	}
	/// 	Расшифровывает данные с файла
	private func decryptionDataFromFile(url: String, nameFile: String)-> Data? {
		guard let fileProvider = fileProvider else { return nil}
		guard let encryptionManager = encryptionManager else { return nil}
		if let data = fileProvider.readFile(nameFile: nameFile) {
			if let decryptData = encryptionManager.decryptionData(data: data) {
				return decryptData//decryptData
			}
		}
		return nil
	}
	/// 	Оригинальную картинку превращает в нужный размер
	private func originalToSize(url: String, nameFile: String,
								size: CGSize?, completion: @escaping (UIImage?) -> Void) {
		guard let imageNameManager = imageNameManager else { return }
		guard let imageResizer = imageResizer else { return }
		if let decryptData = decryptionDataFromFile(url: url,
													nameFile: imageNameManager.getNameFileImage(url: url, size: nil)) {
			if let newData = imageResizer.imageToSize(size: size, data: decryptData) {
				dataToFile(nameFile: nameFile, data: newData)
				completion (UIImage(data: newData))
			} else {
				completion (UIImage(data: decryptData))
			}
		}
	}
	/// 	Записывает Data в файл
	private func dataToFile(nameFile: String, data: Data) {
		guard let encryptionManager = encryptionManager else { return }
		guard let fileProvider = fileProvider else { return }

		let path = fileProvider.getPath(nameFile: nameFile, directory: NSTemporaryDirectory())
		if let encryptData = encryptionManager.encryptionData(data: data) {
			fileProvider.writeToFile(data: encryptData, path: path)//encryptData
		}
	}
	/// 	Скачивает картинку
	private func downloadImage(currentUrl: URL, url: String,
							   nameFileOrigin: String, size: ImageSize, completion: @escaping (Image)->Void) {
		guard let networkService = networkService else { return }
		guard let imageNameManager = imageNameManager else { return }

		networkService.getData(url: currentUrl) { (data) in
			guard let data = data else {completion(Image(image: nil)); return}
			self.dataToFile(nameFile: nameFileOrigin, data: data)
			let nameFile = imageNameManager.getNameFileImage(url: url, size: size.size)
			self.originalToSize(url: url, nameFile: nameFile, size: size.size) { (image) in
				completion(Image(image: image))
			}
		}
	}

	func freeStorage(befora date: Date? = Calendar.current.date(byAdding: .day, value: -2, to: Date())){
		guard let fileProvider = fileProvider else { return }
		fileProvider.removeAllFiles(before: date)
	}
	
	func freeALL() {
		guard let userDefaultsWork = userDefaultsWork else { return }
		guard let imageUrls = imageUrls else { return }
		freeStorage(befora: nil)
		userDefaultsWork.removeObjects(urls: imageUrls.urls)
	}
}
