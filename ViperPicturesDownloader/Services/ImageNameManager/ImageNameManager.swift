import UIKit

final class ImageNameManager: ImageNameManagerProtocol {
	let defaults = UserDefaults.standard
	/// Получает имя файла
	func getNameFileImage(url: String, size: CGSize? = nil)-> String {
		let sizeString = size?.toString() ?? "origin"
		if let dictNameFiles = defaults.object(forKey: url) as? [String:String] {
			print("name was load")
			if let nameFile = dictNameFiles[sizeString] {
				return nameFile
			} else {
				let nameFile = createNameImage()
				var newDictNameFiles = dictNameFiles
				newDictNameFiles[sizeString] = nameFile
				defaults.set(newDictNameFiles, forKey: url)
				print("name was created")
				return nameFile
			}
		}
		let nameFile = createNameImage()
		defaults.set([sizeString: nameFile], forKey: url)
		print("name was created")
		return nameFile
	}
	/// Генерирует имя файла
	private func createNameImage()->String{
		let string = "image" + UUID().uuidString
		return string
	}
}
