//
//  ViperPicturesDownloaderTests.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 11.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

class FileProviderTest: XCTestCase {
	var fileProvider: FileProviderProtocol!
	var fileManagerMock: FileManagerMock!


    override func setUp() {
		fileManagerMock = FileManagerMock()
		fileProvider = FileProvider(fileManager: fileManagerMock)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
		fileManagerMock = nil
		fileProvider = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testCheckDirectorySuccess() {
		fileManagerMock.files = ["file1", "Apple", "Bread"]

		let result = fileProvider.checkDirectory(nameFile: "file1")

		XCTAssert(result, "file didnt found")
	}

	func testCheckDirectoryFailure() {
		fileManagerMock.files = ["file1", "Apple", "Bread"]

		let result = fileProvider.checkDirectory(nameFile: "file")

		XCTAssertFalse(result, "non-existent file found")
	}

	func testRemoveFileWithOldData() {
		fileManagerMock.atributes = [FileAttributeKey.creationDate: Calendar.current.date(byAdding: .day, value: -4, to: Date()) as Any, FileAttributeKey.size: 10000]

		fileProvider.removeFile(nameFile: "file", before: Date())

		XCTAssertTrue(fileManagerMock.remove, "File didnt deleted")
	}

	func testRemoveFileWithNormalData() {
		fileManagerMock.atributes = [FileAttributeKey.creationDate: Date() as Any, FileAttributeKey.size: 10000]

		fileProvider.removeFile(nameFile: "file", before: Calendar.current.date(byAdding: .day, value: -4, to: Date()))

		XCTAssertFalse(fileManagerMock.remove, "File did delete")
	}

	func testRemoveFileWithBigSize() {
		fileManagerMock.atributes = [FileAttributeKey.creationDate: Date(), FileAttributeKey.size: 10000000002]

		fileProvider.removeFile(nameFile: "file", before: Calendar.current.date(byAdding: .day, value: -4, to: Date()))

		XCTAssertTrue(fileManagerMock.remove, "File didnt deleted")
	}

	func testRemoveFileWithNormalSize() {
		fileManagerMock.atributes = [FileAttributeKey.creationDate: Date(), FileAttributeKey.size: 1000]

		fileProvider.removeFile(nameFile: "file", before: Calendar.current.date(byAdding: .day, value: -4, to: Date()))

		XCTAssertFalse(fileManagerMock.remove, "File did deleted")
	}

	func testRemoveFileWithOutDateAndSize() {
		fileManagerMock.atributes = [FileAttributeKey.creationDate: Date(), FileAttributeKey.size: 10]

		fileProvider.removeFile(nameFile: "file", before: nil)

		XCTAssertTrue(fileManagerMock.remove, "File didnt deleted")
	}

	func testRemoveAllFiles() {
		fileManagerMock.files = ["file1", "Apple", "Bread"]
		fileManagerMock.atributes = [FileAttributeKey.creationDate: Date(), FileAttributeKey.size: 10]

		fileProvider.removeAllFiles(before: nil)

		XCTAssertTrue(fileManagerMock.remove, "File didnt deleted")

	}

	func testRemoveFilesWithTypeSuccess() {
		fileManagerMock.files = ["file1", "Apple", "Bread.jpeg"]

		fileProvider.removeFilesWithType()

		XCTAssertTrue(fileManagerMock.remove, "File didnt deleted")
	}

	func testRemoveFilesWithTypeFailure() {
		fileManagerMock.files = ["file1", "Apple", "Bread"]

		fileProvider.removeFilesWithType()

		XCTAssertFalse(fileManagerMock.remove, "File did deleted")
	}
}
