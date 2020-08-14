//
//  MainViewOutPutSpy.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
@testable import ViperPicturesDownloader

class MainViewOutputSpy: MainViewOutput {
	var configure: Bool = false
	var push: Bool = false

	func configureView() {
		configure = true
	}

	func pushCollection() {
		push = true
	}
}
extension MainViewOutputSpy: TableViewDataSourceOutPut {
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
extension MainViewOutputSpy: TableViewDelegateOutput {
	func didSelect(indexPath: IndexPath) {

	}


}
