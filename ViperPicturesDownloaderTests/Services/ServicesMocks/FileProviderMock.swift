//
//  FileProviderMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 12.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
@testable import ViperPicturesDownloader

class FileProviderMock: FileProviderProtocol {
	
	var checkDirectory: Bool = true
	var checkOriginImage: Bool = true
	var changeCheckDirectory: Bool = false
	private var change: Bool = false
	var wasWritten: Bool = false
	var wasRemovedAll: Bool = false
	var result: Data = UIImage(named: "defaultImage")!.pngData()!

	func checkOriginImage(url: String) -> Bool {
		return checkOriginImage
	}

	func checkDirectory(nameFile: String) -> Bool {
		if change {
			checkDirectory = checkDirectory ? false : true
		}
		if changeCheckDirectory {
			change = true
		}
		return checkDirectory
	}

	func readFile(nameFile: String) -> Data? {
		return result
	}

	func getPath(nameFile: String, directory: String) -> String {
		return ""
	}

	func writeToFile(data: Data, path: String) {
		wasWritten = true
	}

	func removeAllFiles(before date: Date?) {
		wasRemovedAll = true
	}

	func removeFile(nameFile: String, before date: Date?) {

	}

	func removeFilesWithType() {
		
	}


}
