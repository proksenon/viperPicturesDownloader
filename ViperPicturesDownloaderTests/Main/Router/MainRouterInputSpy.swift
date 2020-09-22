//
//  MainRouterInputSpy.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
@testable import ViperPicturesDownloader

class MainRouterInputSpy: MainRouterInput {
	var didPushCollection: Bool = false
	var didPush: Bool = false

	func pushCollection(with imageUrls: ImageUrls?) {
		didPushCollection = true
	}

	func push(image: ImageModel) {
		didPush = true
	}

}
