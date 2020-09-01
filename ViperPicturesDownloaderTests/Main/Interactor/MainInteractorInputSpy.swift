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

	var didGetImage: Bool = false
	var getNumberOfRows: Bool = false
	var didFreeStorage: Bool = false
	var didCleanAll: Bool = false
	var number: Int?
	var addUrl: Bool = false
	var didSetImageUrls: Bool = false
	var didsaveImageUrls: Bool = false
	var didDeleteImage: Bool = false
	var didSetImage: Bool = false
	var imageUrls: ImageUrls?

	func getImage(index: Int, size: ImageSize, completion: @escaping (Image) -> Void) {
		didGetImage = true
		completion(Image(image: nil))
	}

	func numberOfRows() -> Int? {
		getNumberOfRows = true
		return number
	}

	func freeStorage(befora date: Date?) {
		didFreeStorage = true
	}

	func freeALL() {
		didFreeStorage = true
	}

	func didAddUrl(urlString: String?) {
		addUrl = true
	}

	func setImageUrls() {
		didSetImageUrls = true
	}

	func saveImageUrls() {
		didsaveImageUrls = true
	}

	func deleteImage(index: Int) {
		didDeleteImage = true
	}

	func setImage(imageModel: Image) {
		didSetImage = true
	}

	func getImageUrls() -> ImageUrls? {
		return imageUrls
	}

}
