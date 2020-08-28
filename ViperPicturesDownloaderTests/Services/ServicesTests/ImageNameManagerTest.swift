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
	var userDefaultsWorkMock: UserDefaultsWorkMock!
	var imageNameManager: ImageNameManagerProtocol!
    override func setUp() {
		userDefaultsWorkMock = UserDefaultsWorkMock()
		imageNameManager = ImageNameManager(userDefaultsWork: userDefaultsWorkMock)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
		userDefaultsWorkMock = nil
		imageNameManager = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testGetNameFileFromDefaultsWhereHasSize() {
		let currentNameFile = "nameFile"
		let stringSize = "25.0x25.0"
		userDefaultsWorkMock.object = [stringSize: currentNameFile]

		let nameFile = imageNameManager.getNamefileFromDefaults(url: "url", sizeString: stringSize)

		XCTAssertTrue(userDefaultsWorkMock.getObjectForKey, "Didnt get values")
		XCTAssertFalse(userDefaultsWorkMock.setObjectForKey, "Did set values")
		XCTAssert(currentNameFile == nameFile, "Another name")
	}

	func testGetNameFileFromDefaultsWhereHasNotSize() {
		let currentNameFile = "nameFile"
		let stringSize = "25.0x25.0"
		userDefaultsWorkMock.object = ["origin": currentNameFile]

		let nameFile = imageNameManager.getNamefileFromDefaults(url: "url", sizeString: stringSize)

		XCTAssertTrue(userDefaultsWorkMock.getObjectForKey, "Didnt get values")
		XCTAssertTrue(userDefaultsWorkMock.setObjectForKey, "Did set values")
		XCTAssert(currentNameFile != nameFile, "Another name")
	}

	func testGetNameFileFromDefaultsFailure() {
		let currentNameFile = "nameFile"
		let stringSize = "25.0x25.0"
		userDefaultsWorkMock.object = "jj"

		let nameFile = imageNameManager.getNamefileFromDefaults(url: "url", sizeString: stringSize)

		XCTAssertTrue(userDefaultsWorkMock.getObjectForKey, "Didnt get values")
		XCTAssertFalse(userDefaultsWorkMock.setObjectForKey, "Did set values")
		XCTAssert(nameFile == nil, "Another name")
	}

	func testGetNameFileImageSuccess() {
		let currentNameFile = "nameFile"
		let stringSize = "25.0x25.0"
		userDefaultsWorkMock.object = ["origin": currentNameFile]

		let nameFile = imageNameManager.getNameFileImage(url: "url", size: nil)

		XCTAssertTrue(userDefaultsWorkMock.getObjectForKey, "Didnt get values")
		XCTAssert(nameFile == currentNameFile, "Another name")
	}
}
