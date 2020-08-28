import Foundation

final class FileProvider: FileProviderProtocol {

	var fileManager: FileManager
	var tempDirectory: String
	let limitedSizeFile = 10000000000

	init(fileManager: FileManager = FileManager(),
		 tempDirectory: String = NSTemporaryDirectory()) {
		self.fileManager = fileManager
		self.tempDirectory = tempDirectory
	}
	func writeToFile(data: Data, path: String){
		do {
			try data.write(to: URL(fileURLWithPath: path))
		} catch let error as NSError {
			print("could't create file text.txt because of error: \(error)")
		}
	}
	
	func checkDirectory(nameFile: String) ->Bool {
		guard let filesInDirectory = getAllFilesFromDirectory() else { return false}
		for file in filesInDirectory {
			if file == nameFile{
				print("\(nameFile) found")
				return true
			}
		}
	   return false
   }

	func readFile(nameFile: String)->Data? {
		let path = getPath(nameFile: nameFile)
		print(tempDirectory.utf8CString )
		print("try to read \(nameFile) with path = \(path)")
		if let contentsOfFile = NSData(contentsOf: URL(fileURLWithPath: path)) as Data? {
			return contentsOfFile
		}
		return nil
	}
	
	func getPath(nameFile: String, directory: String = NSTemporaryDirectory())->String{
		return (directory as NSString).appendingPathComponent(nameFile)
	}
	
	func removeFile(nameFile: String, before date: Date? = Date()) {
		let path = getPath(nameFile: nameFile)
        do {
			let dateFile = try fileManager.attributesOfItem(atPath: path)[FileAttributeKey.creationDate] as? Date
			let sizeFile = try fileManager.attributesOfItem(atPath: path)[FileAttributeKey.size] as? Int
			if let date = date, let dataFile = dateFile, let sizeFile = sizeFile {
				if date > dataFile || sizeFile > limitedSizeFile {
					removeItem(path: path)
				}
			} else {
				removeItem(path: path)
			}
        } catch let error as NSError {
            print("error occured while deleting file: \(error.localizedDescription)")
        }
	}
	
	func removeAllFiles(before date: Date? = Date()) {
		guard let filesInDirectory = getAllFilesFromDirectory() else {return}
		for file in filesInDirectory {
			removeFile(nameFile: file, before: date)
		}
	}

	func removeFilesWithType() {
		guard let filesInDirectory = getAllFilesFromDirectory() else {return}
		for file in filesInDirectory {
			if file.hasSuffix(".jpeg") || file.hasSuffix(".png") {
				let path = getPath(nameFile: file)
				removeItem(path: path)
			}
		}
	}

	private func removeItem(path: String) {
		do {
			try fileManager.removeItem(atPath: path)
		} catch {
			print(error)
		}
	}

	private func getAllFilesFromDirectory(directory: String = NSTemporaryDirectory())-> [String]? {
		do {
			let filesInDirectory = try fileManager.contentsOfDirectory(atPath: directory)
			return filesInDirectory
		} catch {
			print(error)
		}
		return nil
	}
}
