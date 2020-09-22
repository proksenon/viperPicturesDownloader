//
//  TableViewDataSourceOutPutSpy.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
@testable import ViperPicturesDownloader

class TableViewDataSourceOutPutSpy: TableViewDataSourceOutPut {
	var setActivity: Bool = false
	var start: Bool = false
	var stop: Bool = false
	var didGetImage: Bool = false
	var rows: Bool = false

	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (ImageModel) -> Void) {
		didGetImage = true
	}

	func numberOfRows() -> Int {
		rows = true
		return 1
	}
	
}
