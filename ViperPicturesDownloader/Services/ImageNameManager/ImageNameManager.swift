import UIKit

final class ImageNameManager: ImageNameManagerProtocol {
	var defaults: UserDefaults
	let userDefaultsWork = UserDefaultsWork()

	init(defaults: UserDefaults = UserDefaults.standard) {
		self.defaults = defaults
	}
	//[url : [size : namefile]]
	/// Получает имя файла
//	func getNameFileImage(url: String, size: CGSize? = nil)-> String {
//		let sizeString = size?.toString() ?? "origin"
//		if let dictNameFiles = defaults.object(forKey: url) as? [String:String] {
//			print("name was load")
//			if let nameFile = dictNameFiles[sizeString] {
//				return nameFile
//			} else {
//				let nameFile = createNameImage()
//				var newDictNameFiles = dictNameFiles
//				newDictNameFiles[sizeString] = nameFile
//				defaults.set(newDictNameFiles, forKey: url)
//				print("name was created")
//				return nameFile
//			}
//		}
//		let nameFile = createNameImage()
//		defaults.set([sizeString: nameFile], forKey: url)
//		print("name was created")
//		return nameFile
//	}

	func getNameFileImage(url: String, size: CGSize? = nil)-> String {
		let sizeString = size?.toString() ?? "origin"
		if let nameFile = getNamefileFromDefaults(url: url, sizeString: sizeString) {
			return nameFile
		}
		return addNameFileForSize(url: url, sizeString: sizeString, dictNameFiles: [:])
	}

	func getNamefileFromDefaults(url: String, sizeString: String)-> String? {
		if let dictNameFiles = userDefaultsWork.getObject(for: url) as? [String:String] {
			if let nameFile = dictNameFiles[sizeString] {
				return nameFile
			} else {
				return addNameFileForSize(url: url, sizeString: sizeString, dictNameFiles: dictNameFiles)
			}
		}
		return nil
	}
	private func addNameFileForSize(url: String, sizeString: String, dictNameFiles: [String: String])-> String {
		let nameFile = createNameImage()
		var newDictNameFiles = dictNameFiles
		newDictNameFiles[sizeString] = nameFile
		userDefaultsWork.setObject(for: url, object: newDictNameFiles)
		print("name was created")
		return nameFile
	}
	/// Генерирует имя файла
	private func createNameImage()->String{
		let string = "image" + UUID().uuidString
		return string
	}
}
