//
//  MainInteractorInputSpy.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
@testable import ViperPicturesDownloader

class MainInteractorInputSpy: MainInteractorInput {
	func didAddUrl(urlString: String?) {
		
	}

	func setImageUrls() {

	}

	func saveImageUrls() {

	}

	func deleteImage(indexPath: IndexPath) {

	}

	func setImage(imageModel: Image) {

	}

	func getImageUrls() -> ImageUrls {
		return ImageUrls()
	}

	var didGetImage: Bool = false
	var getNumberOfRows: Bool = false
	var didFreeStorage: Bool = false
	var didCleanAll: Bool = false
	var setActivity: Bool = false
	var didStartActivity: Bool = false
	var didStopActivity: Bool = false
	var number = 2

	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image) -> Void) {
		didGetImage = true
		completion(Image(image: nil))
	}

	func numberOfRows() -> Int {
		getNumberOfRows = true
		return number
	}

	func freeStorage(befora date: Date?) {
		didFreeStorage = true
	}

	func freeALL() {
		didFreeStorage = true
	}


}
