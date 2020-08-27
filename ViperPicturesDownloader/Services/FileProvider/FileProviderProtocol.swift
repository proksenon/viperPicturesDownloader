import Foundation

protocol FileProviderProtocol {
	/// Проверяет директорию на существования файла
	func checkDirectory(nameFile: String) ->Bool
	/// Считывает данные с файла
	func readFile(nameFile: String)->Data?
	/// Получает путь к файлу
	func getPath(nameFile: String, directory: String)->String
	/// Записывает данные в файл
	func writeToFile(data: Data, path: String)
	/// Удаляет все файлы
	func removeAllFiles(before date: Date?)
	/// Удаляет файл, при наличии даты, удаляет файл который позднее заданной даты
	func removeFile(nameFile: String, before date: Date?)
	/// Удаляет файл типа jpeg и png
	func removeFilesWithType()
}
