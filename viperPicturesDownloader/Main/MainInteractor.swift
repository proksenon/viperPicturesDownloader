//
//  MainInteractor.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class MainInteractor : MainInteractorProtocol {

	weak var presenter: MainPresenterProtocol!
	let entities = MainEntities()
	var imageNameManager: ImageNameManagerProtocol!
	var fileProvider: FileProviderProtocol!
	var encryptionManager: EncryptionManagerProtocol!
	var networkService: NetworkServiceProtocol!
	var imageResizer: ImageResizerProtocol!
	var userDefaultsWork: UserDefaultsWorkProtocol!
	var activityIndicator: ActivityIndicatorProtocol!

	init(presenter: MainPresenterProtocol, imageNameManager: ImageNameManagerProtocol = ImageNameManager(), fileProvider: FileProviderProtocol = FileProvider(), encryptionManager: EncryptionManagerProtocol = EncryptionManager(), networkService: NetworkServiceProtocol = NetworkService(), imageResizer: ImageResizerProtocol = ImageResizer(), userDefaultsWork: UserDefaultsWorkProtocol = UserDefaultsWork()) {

		self.presenter = presenter
		self.imageNameManager = imageNameManager
		self.fileProvider = fileProvider
		self.encryptionManager = encryptionManager
		self.networkService = networkService
		self.imageResizer = imageResizer
		self.userDefaultsWork = userDefaultsWork
	}

	func setUpActivityIndicator(viewModel: ViewForActivity) {
		activityIndicator = ActivityIndicator(view: viewModel.view)
	}

	func startActivity() {
		activityIndicator.startActivity()
	}
	func stopActivity() {
		activityIndicator.stopActivity()
	}

	func numberOfRows() -> Int {
		return entities.urls.count
	}
	
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void) {
		let url = entities.urls[indexPath.row]
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

	private func decryptionDataFromFile(url: String, nameFile: String)-> Data? {
		if let data = fileProvider.readFile(nameFile: nameFile) {
			if let decryptData = encryptionManager.decryptionData(data: data) {
				return decryptData
			}
		}
		return nil
	}

	private func originalToSize(url: String, nameFile: String, size: CGSize?, completion: @escaping (UIImage?) -> Void) {
		if let decryptData = decryptionDataFromFile(url: url, nameFile: imageNameManager.getNameFileImage(url: url, size: nil)) {
			if let newData = imageResizer.imageToSize(nameFile: nameFile, size: size, data: decryptData) {
				completion (UIImage(data: newData))
				dataToFile(nameFile: nameFile, data: newData)
			} else {
				completion (UIImage(data: decryptData))
			}
		}
	}

	private func dataToFile(nameFile: String, data: Data) {
		let path = self.fileProvider.getPath(nameFile: nameFile, directory: NSTemporaryDirectory())
		if let encryptData = encryptionManager.encryptionData(data: data) {
			self.fileProvider.writeToFile(data: encryptData, path: path)
		}
	}

	private func downloadImage(currentUrl: URL, url: String, nameFileOrigin: String, size: ImageSize, completion: @escaping (Image)->Void) {
		networkService.getData(url: currentUrl) { (data) in
			self.dataToFile(nameFile: nameFileOrigin, data: data)
			let nameFile = self.imageNameManager.getNameFileImage(url: url, size: size.size)
			self.originalToSize(url: url, nameFile: nameFile, size: size.size) { (image) in
				completion(Image(image: image))
			}
		}
	}

	func freeStorage(befora date: Date? = Calendar.current.date(byAdding: .day, value: -2, to: Date())){
		fileProvider.removeAllFiles(before: date)
	}

	func freeALL() {
		freeStorage(befora: nil)
		userDefaultsWork.removeObjects(urls: entities.urls)
	}
}
