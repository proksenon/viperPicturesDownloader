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

	func setUpActivity(viewModel: ViewForActivity) {

	}

	func startActivity() {

	}

	func stopActivity() {

	}

	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image) -> Void) {
		completion(Image(image: nil))
	}

	func numberOfRows() -> Int {
		return 1
	}


}
