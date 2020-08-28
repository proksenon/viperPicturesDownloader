//
//  CustomTableViewDelegateTest.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

//class CustomTableViewDelegateTest: XCTestCase {
//	var delegate: UITableViewDelegate!
//	var tableView: TableViewMock!
//	var outPut: TableViewDelegateOutputSpy!
//    override func setUp() {
//		tableView = TableViewMock(frame: CGRect(x: 0, y: 0, width: 200, height: 500), style: .grouped)
//		outPut = TableViewDelegateOutputSpy()
//		delegate = CustomTableViewDelegate(tableView: tableView, output: outPut)
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//		tableView = nil
//		outPut = nil
//		delegate = nil
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//	func testDidSelecetCell() {
//		delegate.tableView?(tableView, didSelectRowAt: IndexPath(row: 1, section: 1))
//
//		XCTAssertTrue(outPut.select, "Didnt select cell")
//	}
//
//}
