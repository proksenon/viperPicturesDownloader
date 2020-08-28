//
//  CustomDataSourceTest.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

//class CustomTableViewDataSourceTest: XCTestCase {
//	var dataSource: UITableViewDataSource!
//	var tableView: TableViewMock!
//	var outPut: TableViewDataSourceOutPutSpy!
//
//    override func setUp() {
//		tableView = TableViewMock(frame: CGRect(x: 0, y: 0, width: 200, height: 500), style: .grouped)
//		outPut = TableViewDataSourceOutPutSpy()
//		dataSource = CustomTableViewDataSource(tableView: tableView, output: outPut)
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDown() {
//		tableView = nil
//		outPut = nil
//		dataSource = nil
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//	func testNumberOfRows() {
//		dataSource.tableView(tableView, numberOfRowsInSection: 1)
//
//		XCTAssertTrue(outPut.rows, "Didnt init number of rows")
//	}
//
//	func testCellForRow() {
//		dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 1))
//
//		XCTAssertTrue(outPut.setActivity, "Activivty indicator didnt set")
//		XCTAssertTrue(outPut.start, "Activity indicator didnt start")
//		XCTAssertTrue(outPut.didGetImage, "didnt get Image")
//		//Выполняется внутри функции асинхронно, хз как проверить
////		XCTAssertTrue(outPut.stop, "Activity indicator didnt stop")
//	}
//
//}
