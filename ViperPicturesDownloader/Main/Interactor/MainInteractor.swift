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

	weak var output: MainInteractorOutput?
	private var imageNameManager: ImageNameManagerProtocol?
	private var fileProvider: FileProviderProtocol?
	private var encryptionManager: EncryptionManagerProtocol?
	private var networkService: NetworkServiceProtocol?
	private var imageResizer: ImageResizerProtocol?
	private var userDefaultsWork: UserDefaultsWorkProtocol?

	init(presenter: MainInteractorOutput,
		 imageNameManager: ImageNameManagerProtocol = ImageNameManager(),
		 fileProvider: FileProviderProtocol = FileProvider(),
		 encryptionManager: EncryptionManagerProtocol = EncryptionManager(),
		 networkService: NetworkServiceProtocol = NetworkService(),
		 imageResizer: ImageResizerProtocol = ImageResizer(),
		 userDefaultsWork: UserDefaultsWorkProtocol = UserDefaultsWork()) {

		self.output = presenter
		self.imageNameManager = imageNameManager
		self.fileProvider = fileProvider
		self.encryptionManager = encryptionManager
		self.networkService = networkService
		self.imageResizer = imageResizer
		self.userDefaultsWork = userDefaultsWork
	}
	// MARK: - WorkWithImage
	func deleteImage(urlDelete: String) {
		guard let userDefaultsWork = userDefaultsWork else { return }
		guard let fileProvider = fileProvider else { return }

		if let imagesSize = userDefaultsWork.getObject(for: urlDelete) as? [String: String] {
			for (_, nameFile) in imagesSize {
				fileProvider.removeFile(nameFile: nameFile, before: nil)
			}
		}
		userDefaultsWork.removeObjects(urls: [urlDelete])
	}

	func setImageUrls()-> ImageUrls? {
		guard let userDefaultsWork = userDefaultsWork else { return nil }
		if let imageUrlsFromStorage: ImageUrls = userDefaultsWork.getObjectWithDecoder(for: "imageUrls") {
			 return imageUrlsFromStorage
		} else {
			return ImageUrls()
		}
	}

	func saveImageUrls(imageUrls: ImageUrls?) {
		guard let userDefaultsWork = userDefaultsWork else { return }
		userDefaultsWork.setObjectWithDecoder(for: "imageUrls", object: imageUrls)
	}

	func setImage(imageModel: ImageWithUrl)-> String? {

		guard let imageNameManager = imageNameManager else { return nil }
		guard let fileProvider = fileProvider else { return nil }

		var imageUrlString: String?
		var imageFormat: ImageFormat = .png
		guard let image = imageModel.image else { return nil }
		if imageModel.urlString == nil {
			imageUrlString = UUID().uuidString
			imageFormat = .jpeg
		} else {
			guard let urlString = imageModel.urlString else { return nil }
			imageUrlString = urlString
			if urlString.hasSuffix(".jpeg") {
				imageFormat = .jpeg
			}
		}
		guard let data = imageToDataWith(format: imageFormat, image: image), let imageUrl = imageUrlString else { return nil }
		fileProvider.removeFilesWithType()
		let nameFile = imageNameManager.getNameFileImage(url: imageUrl, size: nil)
		if !fileProvider.checkDirectory(nameFile: nameFile) {
			dataToFile(nameFile: nameFile, data: data)
			return imageUrl
		}
		return nil
	}
	
	private func imageToDataWith(format: ImageFormat, image: UIImage)-> Data? {
		switch format {
		case .jpeg:
			return image.jpegData(compressionQuality: 1)
		default:
			return image.pngData()
		}
	}

	func getImage(imageUrl: String, size: ImageSize, completion: @escaping (ImageModel)->Void) {
		guard let imageNameManager = imageNameManager else { return }
		guard let fileProvider = fileProvider else { return }
		let nameFileOrigin = imageNameManager.getNameFileImage(url: imageUrl, size: nil)
		if fileProvider.checkDirectory(nameFile: nameFileOrigin) {
			imageFromCache(url: imageUrl, size: size) { (imageModel) in
				completion(imageModel)
			}
		} else {
			if let currentUrl = URL(string: imageUrl) {
				downloadImage(currentUrl: currentUrl, url: imageUrl, nameFileOrigin: nameFileOrigin, size: size) { (imageModel) in
					if imageModel.image == nil {
						completion(ImageModel(image: UIImage(named: "defaultImage")))
					} else {
						completion(imageModel)
					}
				}
			}
		}
	}
	/// 	Получает картинку с файлов
	private func imageFromCache(url: String, size: ImageSize, completion: @escaping (ImageModel)->Void) {
		guard let imageNameManager = imageNameManager else { return }
		guard let fileProvider = fileProvider else { return }

		let nameFile = imageNameManager.getNameFileImage(url: url, size: size.size)
		if fileProvider.checkDirectory(nameFile: nameFile) {
			if let decryptData = decryptionDataFromFile(url: url, nameFile: nameFile) {
				let image = ImageModel(image: UIImage(data: decryptData))
				completion(image)
			}
		} else {
			originalToSize(url: url, nameFile: nameFile, size: size.size) { (image) in
				completion(ImageModel(image: image))
				}
			}
	}
	/// 	Расшифровывает данные с файла
	private func decryptionDataFromFile(url: String, nameFile: String)-> Data? {
		guard let fileProvider = fileProvider else { return nil}
		guard let encryptionManager = encryptionManager else { return nil}
		if let data = fileProvider.readFile(nameFile: nameFile) {
			if let decryptData = encryptionManager.decryptionData(data: data) {
				return decryptData
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
							   nameFileOrigin: String, size: ImageSize, completion: @escaping (ImageModel)->Void) {
		guard let networkService = networkService else { return }
		guard let imageNameManager = imageNameManager else { return }

		networkService.getData(url: currentUrl) { (data) in
			guard let data = data else {completion(ImageModel(image: nil)); return}
			self.dataToFile(nameFile: nameFileOrigin, data: data)
			let nameFile = imageNameManager.getNameFileImage(url: url, size: size.size)
			self.originalToSize(url: url, nameFile: nameFile, size: size.size) { (image) in
				completion(ImageModel(image: image))
			}
		}
	}
	// MARK: - CleanFileBase
	func freeStorage(befora date: Date? = Calendar.current.date(byAdding: .day, value: -2, to: Date())){
		guard let fileProvider = fileProvider else { return }
		fileProvider.removeAllFiles(before: date)
	}
	
	func freeALL(imageUrls: ImageUrls) {
		guard let userDefaultsWork = userDefaultsWork else { return }
		freeStorage(befora: nil)
		userDefaultsWork.removeObjects(urls: imageUrls.urls)
	}
}
