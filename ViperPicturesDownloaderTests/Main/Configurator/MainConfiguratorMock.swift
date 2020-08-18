//
//  MainConfiguratorMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
@testable import ViperPicturesDownloader

class MainConfiguratorMock: MainConfiguratorProtocol {
	var output: MainViewOutputSpy!

	init(output: MainViewOutputSpy! = MainViewOutputSpy()) {
		self.output = output
	}

	func configure(with viewController: MainViewController) {
		viewController.outout = output
	}


}
