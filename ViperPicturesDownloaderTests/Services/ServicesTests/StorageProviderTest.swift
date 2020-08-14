//
//  StorageProviderTest.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

class StorageProviderTest: XCTestCase {

	var storageProvider: StorageProviderProtocol!
	var fileProvider: FileProviderMock!
	var userDefaultsWork: UserDefaultsWorkMock!
	override func setUp() {
		fileProvider = FileProviderMock()
		userDefaultsWork = UserDefaultsWorkMock()
		storageProvider = StorageProvider(fileProvider: fileProvider, userDefaultsWork: userDefaultsWork)

		// Put setup code here. This method is called before the invocation of each test method in the class.
	}

	override func tearDown() {
		fileProvider = nil
		userDefaultsWork = nil
		storageProvider = nil
		// Put teardown code here. This method is called after the invocation of each test method in the class.
	}
	func testFreeStorage() {
		storageProvider.freeStorage(befora: Date())

		XCTAssertTrue(fileProvider.wasRemovedAll, "didnt clean")
	}
	func testFreeAll() {
		storageProvider.freeALL(urls: [""])

		XCTAssertTrue(fileProvider.wasRemovedAll, "didnt clean")
		XCTAssertTrue(userDefaultsWork.remove, "UserDefaults didnt clean")
	}

}
