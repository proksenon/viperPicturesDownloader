import Foundation

final class FileProvider: FileProviderProtocol {
	let defaults = UserDefaults.standard
	let fileManager = FileManager()
	let tempDirectory = NSTemporaryDirectory()
	let limitedSizeFile = 10000000000

	/// Записывает данные в файл
	func writeToFile(data: Data, path: String){
		do {
			try data.write(to: URL(fileURLWithPath: path))
			print("File text.txt created at temp directory")
		} catch let error as NSError {
			print("could't create file text.txt because of error: \(error)")
		}
	}
	/// Проверяет директорию на существования файла
	func checkDirectory(nameFile: String) ->Bool {
		do {
			let filesInDirectory = try fileManager.contentsOfDirectory(atPath: tempDirectory)
			for file in filesInDirectory {
				if file == nameFile{
					print("\(nameFile) found")
					return true
				}
			}
			print("File not found")
		   } catch let error as NSError {
			   print(error)
		   }
		   return false
	   }
	/// Считывает данные с файла
	func readFile(nameFile: String)->Data? {
		let path = getPath(nameFile: nameFile)
		print("try to read \(nameFile) with path = \(path)")
		if let contentsOfFile = NSData(contentsOf: URL(fileURLWithPath: path)) as Data? {
			print("return data")
			return contentsOfFile
		}
		return nil
	}
	/// Получает путь к файлу
	func getPath(nameFile: String, directory: String = NSTemporaryDirectory())->String{
		return (directory as NSString).appendingPathComponent(nameFile)
	}
	/// Удаляет ненужные файлы
	func removeFile(nameFile: String, before date: Date? = Date()) {
        do {
			let path = getPath(nameFile: nameFile)
			let dateFile = try fileManager.attributesOfItem(atPath: path)[FileAttributeKey.creationDate] as? Date
			let sizeFile = try fileManager.attributesOfItem(atPath: path)[FileAttributeKey.size] as? Int
			if let date = date, let dataFile = dateFile, let sizeFile = sizeFile {
				if date > dataFile || sizeFile > limitedSizeFile {
					try fileManager.removeItem(atPath: path)
					print("file deleted")
				}
			} else {
				try fileManager.removeItem(atPath: path)
				print("file deleted")
			}
        } catch let error as NSError {
            print("error occured while deleting file: \(error.localizedDescription)")
        }
	}
	/// Удаляет все файлы
	func removeAllFiles(before date: Date? = Date()) {
		do {
			let filesInDirectory = try fileManager.contentsOfDirectory(atPath: tempDirectory)
			for file in filesInDirectory {
				removeFile(nameFile: file, before: date)
			}
		} catch let error as NSError {
            print("error occured while deleting file: \(error.localizedDescription)")
        }
	}

}
