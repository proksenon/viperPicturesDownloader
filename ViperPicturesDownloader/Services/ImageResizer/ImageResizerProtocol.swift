import UIKit

protocol ImageResizerProtocol {
	func imageToSize(nameFile:String, size: CGSize?, data: Data?) ->Data?
}
