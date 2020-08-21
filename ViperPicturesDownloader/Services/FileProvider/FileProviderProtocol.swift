import Foundation

protocol FileProviderProtocol {
	func checkDirectory(nameFile: String) ->Bool
	func readFile(nameFile: String)->Data?
	func getPath(nameFile: String, directory: String)->String
	func writeToFile(data: Data, path: String)
	func removeAllFiles(before date: Date?)
	func removeFile(nameFile: String, before date: Date?)
}
