import UIKit

protocol ImageNameManagerProtocol {
	/// Дает имя файла, обращается к хранящимся данным и, если там нет для такой картинки имя, создает его
	func getNameFileImage(url: String, size: CGSize?)-> String
	func getNamefileFromDefaults(url: String, sizeString: String)-> String?
}
