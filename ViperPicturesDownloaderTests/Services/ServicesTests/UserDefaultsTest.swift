//
//  UserDefaultsTest.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

class UserDefaultsTest: XCTestCase {
	var userDefaultsWork: UserDefaultsWorkProtocol!
	var userDefaultsMock: UserDefaultsMock!

    override func setUp() {
		userDefaultsMock = UserDefaultsMock()
		userDefaultsWork = UserDefaultsWork(defaults: userDefaultsMock)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
		userDefaultsMock = nil
		userDefaultsWork = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	func testRemoveObjects() {
		userDefaultsWork.removeObjects(urls: [""])

		XCTAssertTrue(userDefaultsMock.remove, "Didnt remove data")
		XCTAssertTrue(userDefaultsMock.synchron, "Didnt synchrone data")
	}
}
