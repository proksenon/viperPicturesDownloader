//
//  FileManagerMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 28.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

class FileManagerMock: FileManager {

	var files: [String]!
	var remove: Bool = false
	var atributes: [FileAttributeKey : Any]!

	override func contentsOfDirectory(atPath path: String) throws -> [String] {
		return files
	}

	override func removeItem(atPath path: String) throws {
		remove = true
	}

	override func attributesOfItem(atPath path: String) throws -> [FileAttributeKey : Any] {
		return atributes
	}
}
