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
	var fileProvider: FileProvider!

    override func setUp() {
		fileProvider = FileProvider()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
		fileProvider = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func getFilesFromTempDirect()->[String]? {
		do {
			let files = try fileProvider.fileManager.contentsOfDirectory(atPath: fileProvider.tempDirectory)
			XCTAssert(files.count >= 0, "files didnt exist")
			return files

		} catch let error {
			XCTAssertNotNil(error)
		}
		return nil
	}

	func testFileFounden() {

		let hasNtFile = fileProvider.checkDirectory(nameFile: "asda")
		if let files = getFilesFromTempDirect() {
			let hasFile = fileProvider.checkDirectory(nameFile: files[0])
			XCTAssert(hasFile, "existent file didnt founded")
		}
		XCTAssert(!hasNtFile, "non-existent file was founded")
	}

	func testGetImage() {
	let interactor = MainInteractor(presenter: MainPresenter(view: MainViewController()))
	var testImage: UIImage?
		interactor.getImage(indexPath: IndexPath(row: 2, section: 1), size: ImageSize(size: nil)) { (image) in
			testImage = image.image
		}
	XCTAssertNotNil(testImage)
	}

	func testDataFromFileCheck() {

		let nameFile: String!

		if let files = getFilesFromTempDirect() {
			nameFile = files[0]
			let data = fileProvider.readFile(nameFile: nameFile)
			let nilData = fileProvider.readFile(nameFile: "Foo")
			XCTAssertNotNil(data, "existent data didnt")
			XCTAssertNil(nilData, "non-existent data")
		}
	}

//	func testClearFiles() {
//		let fileProvider = FileProvider()
//		fileProvider.removeAllFiles(before: Date())
//		XCTAssert(try fileProvider.fileManager.contentsOfDirectory(atPath: fileProvider.tempDirectory).count == 0, "directory is nt clear")
//	}

}
