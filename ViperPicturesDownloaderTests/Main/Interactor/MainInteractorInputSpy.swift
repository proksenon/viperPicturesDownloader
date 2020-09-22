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
	var url: String?

	func getImage(imageUrl: String, size: ImageSize, completion: @escaping (ImageModel) -> Void) {
		didGetImage = true
		completion(ImageModel(image: nil))
	}

	func numberOfRows() -> Int? {
		getNumberOfRows = true
		return number
	}

	func freeStorage(befora date: Date?) {
		didFreeStorage = true
	}

	func freeALL(imageUrls: ImageUrls) {
		didFreeStorage = true
	}

	func didAddUrl(urlString: String?) {
		addUrl = true
	}

	func setImageUrls() -> ImageUrls? {
		didSetImageUrls = true
		return imageUrls
	}

	func saveImageUrls(imageUrls: ImageUrls?) {
		didsaveImageUrls = true
	}

	func deleteImage(urlDelete: String) {
		didDeleteImage = true
	}

	func setImage(imageModel: ImageWithUrl) -> String? {
		didSetImage = true
		return url
	}

	func getImageUrls() -> ImageUrls? {
		return imageUrls
	}

}
