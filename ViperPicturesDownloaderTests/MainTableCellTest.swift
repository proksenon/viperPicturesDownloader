//
//  MainTableCellTest.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 12.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

class MainTableCellTest: XCTestCase {

	func testBuildCell() {
		let cell = CustomTableViewCell(style: .default, reuseIdentifier: "cell")

		XCTAssertNotNil(cell.customImageView)
		XCTAssertFalse(cell.customImageView.translatesAutoresizingMaskIntoConstraints)
	}

}
