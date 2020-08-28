import UIKit

final class ImageNameManager: ImageNameManagerProtocol {
	var userDefaultsWork: UserDefaultsWorkProtocol

	init(userDefaultsWork: UserDefaultsWorkProtocol = UserDefaultsWork()) {
		self.userDefaultsWork = userDefaultsWork
	}

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
		return nameFile
	}

	private func createNameImage()->String{
		let string = "image" + UUID().uuidString
		return string
	}
}
