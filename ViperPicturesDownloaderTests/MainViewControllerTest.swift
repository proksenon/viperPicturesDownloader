//
//  MainViewControllerTest.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader
class MainViewControllerTest: XCTestCase {

	var viewComtroller: MainViewController!
	var output: MainViewOutputSpy!
	var configurator: MainConfiguratorMock!

    override func setUp() {
		output = MainViewOutputSpy()
		configurator = MainConfiguratorMock(output: output)
		viewComtroller = MainViewController(configurator: configurator)

        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
		viewComtroller = nil
		configurator = nil
		output = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	func testViewDidLoad() {
		viewComtroller.viewDidLoad()

		XCTAssertTrue(output.configure, "Didnt configure MainView")
	}

	func testPushCollection() {
		viewComtroller.viewDidLoad()
		viewComtroller.makeCollection()

		XCTAssertTrue(output.push, "Didnt set push")
	}

}
