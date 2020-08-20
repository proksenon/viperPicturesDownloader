import UIKit

protocol ImageNameManagerProtocol {
	func getNameFileImage(url: String, size: CGSize?)-> String
	func getNamefileFromDefaults(url: String, sizeString: String)-> String?
}
