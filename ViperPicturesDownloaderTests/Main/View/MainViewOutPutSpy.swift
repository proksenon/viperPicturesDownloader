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

	func didAddUrl(urlString: String?) {

	}

	func presentAlert() {

	}

	func imageFromLibrary(imageModel: ImageWithUrl) {

	}

	func configureView() {
		configure = true
	}

	func pushCollection() {
		push = true
	}
}
