//
//  MainInteractorInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol MainInteractorInput: class {
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	func numberOfRows() -> Int
	func freeStorage(befora date: Date?)
	func freeALL()
	func didAddUrl(urlString: String?)
	func setImageUrls()
	func saveImageUrls()
	func deleteImage(indexPath: IndexPath)
	func setImage(imageModel: Image)
	func getImageUrls() -> ImageUrls
}
