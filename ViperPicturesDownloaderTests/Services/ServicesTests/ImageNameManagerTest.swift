//
//  ImageNameManagerTest.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

class ImageNameManagerTest: XCTestCase {
	var defaults: UserDefaultsMock!
	var imageNameManager: ImageNameManagerProtocol!
    override func setUp() {
		defaults = UserDefaultsMock()
		imageNameManager = ImageNameManager(defaults: defaults)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testGetNameFileFromUserDefaults() {
		defaults.keys.append("key")
		let currentNameFile = "nameFile"
		defaults.result = ["25.0x25.0": currentNameFile]
		let nameFile = imageNameManager.getNameFileImage(url: "key", size: CGSize(width: 25, height: 25) )

		XCTAssert(nameFile == currentNameFile , "Didnt get namFile from UserDefaults")
	}
	func testGetNameFileForImageWithSizeWhichHasOriginImage() {
		defaults.keys.append("key")
		let currentNameFile = "nameFile"
		defaults.result = ["origin": currentNameFile]
		let nameFile = imageNameManager.getNameFileImage(url: "key", size: CGSize(width: 25, height: 25) )

		XCTAssertTrue(defaults.setNewName, "New name didnt set")
		XCTAssert(nameFile != currentNameFile, "New name didnt change")
	}

	func testCreateNewNameAndSetToUserDefaults() {
		let nameFile = imageNameManager.getNameFileImage(url: "key", size: CGSize(width: 25, height: 25) )

		XCTAssertTrue(defaults.setNewName, "New name didnt set")
	}

}
