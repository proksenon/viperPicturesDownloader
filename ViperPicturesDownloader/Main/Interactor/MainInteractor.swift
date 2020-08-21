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

	weak var presenter: MainInteractorOutput!
	var imageUrls: ImageUrls!
	var imageNameManager: ImageNameManagerProtocol!
	var fileProvider: FileProviderProtocol!
	var encryptionManager: EncryptionManagerProtocol!
	var networkService: NetworkServiceProtocol!
	var imageResizer: ImageResizerProtocol!
	var userDefaultsWork: UserDefaultsWorkProtocol!
	var activityIndicator: ActivityIndicatorProtocol!
	let imageFilterManager = ImageFilterManager()

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

	func deleteImage(indexPath: IndexPath) {
		let urlDelete = imageUrls.urls[indexPath.row]
		if let nameFile = imageNameManager.getNamefileFromDefaults(url: urlDelete, sizeString: "origin") {
			fileProvider.removeFile(nameFile: nameFile, before: nil)
		}
		userDefaultsWork.removeObjects(urls: [urlDelete])
		imageUrls.urls.remove(at: indexPath.row)
		saveImageUrls()
	}

	func didAddUrl(urlString: String?) {
		if let url = urlString {
			imageUrls.urls.append(url)
			saveImageUrls()
		}
	}
	func getImageUrls() {
		if let imageUrlsFromStorage: ImageUrls = userDefaultsWork.getObjectWithDecoder(for: "imageUrls") {
			imageUrls = imageUrlsFromStorage
		} else {
			imageUrls = ImageUrls()
		}
	}

	func saveImageUrls() {
		userDefaultsWork.setObjectWithDecoder(for: "imageUrls", object: imageUrls)
	}
	/// Устанавливает ActivityIndicator
	func setUpActivityIndicator(viewModel: ViewForActivity) {
		activityIndicator = ActivityIndicator(view: viewModel.view)
	}
	/// Включает ActivityIndicator
	func startActivity() {
		activityIndicator.startActivity()
	}
	/// Выключает ActivityIndicator
	func stopActivity() {
		activityIndicator.stopActivity()
	}
	/// Количество ячеек
	func numberOfRows() -> Int {
		return imageUrls.urls.count
	}
	func getImageWithBlur(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void) {
		getImage(indexPath: indexPath, size: size) { (image) in
			self.imageFilterManager.originImage = image.image
			let imageWithBlur = self.imageFilterManager.apllyFilter(indexPath: IndexPath(row: 5, section: 1))
			completion(Image(image: imageWithBlur))
		}
	}
	/// Получает картинку
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void) {
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
	/// Получает картинку с файлов
	private func imageFromCache(url: String, size: ImageSize, completion: @escaping (Image)->Void) {
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
	/// Расшифровывает данные с файла
	private func decryptionDataFromFile(url: String, nameFile: String)-> Data? {
		if let data = fileProvider.readFile(nameFile: nameFile) {
			if let decryptData = encryptionManager.decryptionData(data: data) {
				return decryptData
			}
		}
		return nil
	}
	/// Оригинальную картинку превращает в нужный размер
	private func originalToSize(url: String, nameFile: String,
								size: CGSize?, completion: @escaping (UIImage?) -> Void) {
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
	/// Записывает дата в файл
	private func dataToFile(nameFile: String, data: Data) {
		let path = self.fileProvider.getPath(nameFile: nameFile, directory: NSTemporaryDirectory())
		if let encryptData = encryptionManager.encryptionData(data: data) {
			self.fileProvider.writeToFile(data: encryptData, path: path)
		}
	}
	/// Скачивает картинку
	private func downloadImage(currentUrl: URL, url: String,
							   nameFileOrigin: String, size: ImageSize, completion: @escaping (Image)->Void) {
		networkService.getData(url: currentUrl) { (data) in
			guard let data = data else {completion(Image(image: nil)); return}
			self.dataToFile(nameFile: nameFileOrigin, data: data)
			let nameFile = self.imageNameManager.getNameFileImage(url: url, size: size.size)
			self.originalToSize(url: url, nameFile: nameFile, size: size.size) { (image) in
				completion(Image(image: image))
			}
		}
	}
	/// Очищает хранилище, удаляя файлы, которые лежат больше 2 дней
	func freeStorage(befora date: Date? = Calendar.current.date(byAdding: .day, value: -2, to: Date())){
		fileProvider.removeAllFiles(before: date)
	}
	/// Полностью очищает хранилище
	func freeALL() {
		freeStorage(befora: nil)
		userDefaultsWork.removeObjects(urls: imageUrls.urls)
	}
}
