//
//  MainViewInputSpy.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
@testable import ViperPicturesDownloader

class MainViewInputSpy: MainViewInput {
	var didSetTable: Bool = false
	var didSetButton: Bool = false

	func setTableView() {
		didSetTable = true
	}

	func setButton() {
		didSetButton = true
	}

}
