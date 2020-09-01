//
//  CollectionInteractor.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
/// Интерактор экрана с колекцией
final class CollectionInteractor: CollectionInteractorInput {
	
	weak var presenter: CollectionInteractorOutput?
	var imageUrls: ImageUrls?
	private var imageNameManager: ImageNameManagerProtocol?
	private var fileProvider: FileProviderProtocol?
	private var encryptionManager: EncryptionManagerProtocol?
	private var networkService: NetworkServiceProtocol?
	private var imageResizer: ImageResizerProtocol?

	init(presenter: CollectionInteractorOutput,
		 imageNameManager: ImageNameManagerProtocol = ImageNameManager(),
		 fileProvider: FileProviderProtocol = FileProvider(),
		 encryptionManager: EncryptionManagerProtocol = EncryptionManager(),
		 networkService: NetworkServiceProtocol = NetworkService(),
		 imageResizer: ImageResizerProtocol = ImageResizer()) {

		self.presenter = presenter
		self.imageNameManager = imageNameManager
		self.fileProvider = fileProvider
		self.encryptionManager = encryptionManager
		self.networkService = networkService
		self.imageResizer = imageResizer
	}
	
	func setImageUrls(with urls: ImageUrls) {
		imageUrls = urls
	}
	
	func numberOfRows() -> Int {
		guard let imageUrls = imageUrls else { return 0 }
		return imageUrls.urls.count
	}

	func getImage(index: Int, size: ImageSize, completion: @escaping (Image)->Void) {
		guard let imageUrls = imageUrls else { return }
		guard let imageNameManager = imageNameManager else { return }
		guard let fileProvider = fileProvider else { return }

		let url = imageUrls.urls[index]
		let nameFileOrigin = imageNameManager.getNameFileImage(url: url, size: nil)
		if fileProvider.checkDirectory(nameFile: nameFileOrigin) {
			imageFromCache(url: url, size: size) { (image) in
				completion(image)
			}
		} else {
			if let currentUrl = URL(string: url) {
				downloadImage(currentUrl: currentUrl, url: url, nameFileOrigin: nameFileOrigin, size: size) { (image) in
					completion(image)
				}
			}
		}
	}
	///		Получает картинку с файлов
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
		guard let fileProvider = fileProvider else { return nil }
		guard let encryptionManager = encryptionManager else { return nil }

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
				completion (UIImage(data: newData))
				dataToFile(nameFile: nameFile, data: newData)
			} else {
				completion (UIImage(data: decryptData))
			}
		}
	}
	/// 	Записывает дата в файл
	private func dataToFile(nameFile: String, data: Data) {
		guard let fileProvider = fileProvider else { return }
		guard let encryptionManager = encryptionManager else { return }

		let path = fileProvider.getPath(nameFile: nameFile, directory: NSTemporaryDirectory())
		if let encryptData = encryptionManager.encryptionData(data: data) {
			fileProvider.writeToFile(data: encryptData, path: path)
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

}
