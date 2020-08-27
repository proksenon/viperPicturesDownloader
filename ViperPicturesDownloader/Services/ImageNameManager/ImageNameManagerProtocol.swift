import UIKit

protocol ImageNameManagerProtocol {
	///  Полуает имя файла, обращается к хранящимся данным и, если там нет для такой картинки имя, создает его
	func getNameFileImage(url: String, size: CGSize?)-> String
	///  Получает имя файла с UserDefaults
	func getNamefileFromDefaults(url: String, sizeString: String)-> String?
}
