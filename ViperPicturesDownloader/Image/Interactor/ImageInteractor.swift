//
//  ImageInteractor.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
/// Интерактор экрана с картиной
class ImageInteractor: ImageInteractorInput {

	weak var presenter: ImageInteractorOuput!
	var imageFilterManager: ImageFilterManagerProtocol!
	var originImage: Image! {
		didSet {
			let image = originImage.image?.resizeImage(targetSize: ImageSize().size!)
			resizedImage = Image(image: image)
		}
	}
	var resizedImage: Image!
	var lastIndex: IndexPath?
	var lastCustomParametrs: CustomParameters?

	init(presenter: ImageInteractorOuput, imageFilterManager: ImageFilterManagerProtocol = ImageFilterManager()) {
		self.presenter = presenter
		self.imageFilterManager = imageFilterManager
	}

	func getParamsAt(indexPath: IndexPath)->[DefaultParameters]? {
		return imageFilterManager.getParametrs(indexPath: indexPath)
	}

	func originImageSet(image: Image) {
		originImage = image
	}

	func saveImageToLibrary() {
		guard let index = lastIndex else {
			guard let image = originImage.image else {return}
			UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil)
			return
		}

		imageFilterManager.apllyFilter(image: originImage.image, indexPath: index, customParametrs: lastCustomParametrs) { (image) in
			if let image = image {
				UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil)
			}
		}
	}

	func originImageGet()-> Image {
		return originImage
	}

	func filterToImage(indexPath: IndexPath, customParametrs: CustomParameters? = nil, completion: @escaping (Image)->Void){
		lastIndex = indexPath
		lastCustomParametrs = customParametrs

		imageFilterManager.apllyFilter(image: resizedImage.image, indexPath: indexPath, customParametrs: customParametrs) { (image) in
			completion(Image(image: image))
		}
	}

	func numberOfRows()-> Int {
		return imageFilterManager.countFilters
	}
	
	func getFilterIcon(indexPath: IndexPath)-> Image {
		if let imageIconModel = imageFilterManager.getFiltersIcon(indexPath: indexPath) {
			return imageIconModel
		} else {
			return Image(image: nil)
		}
	}
}
