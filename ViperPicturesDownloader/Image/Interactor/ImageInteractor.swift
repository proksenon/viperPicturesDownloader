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

	weak var presenter: ImageInteractorOuput?
	var imageFilterManager: ImageFilterManagerProtocol?
	var originImage: Image? {
		didSet {
			guard let originImage = originImage else { return }
			let image = originImage.image?.resizeImage(targetSize: ImageSize().size!)
			resizedImage = Image(image: image)
		}
	}
	var resizedImage: Image?
	var lastIndex: IndexPath?
	var lastCustomParametrs: CustomParameters?

	init(presenter: ImageInteractorOuput, imageFilterManager: ImageFilterManagerProtocol = ImageFilterManager()) {
		self.presenter = presenter
		self.imageFilterManager = imageFilterManager
	}

	func getParamsAt(indexPath: IndexPath)->[DefaultParameters]? {
		guard let imageFilterManager = imageFilterManager else { return nil}
		return imageFilterManager.getParametrs(indexPath: indexPath)
	}

	func originImageSet(image: Image) {
		originImage = image
	}

	func saveImageToLibrary() {
		guard let originImage = originImage else { return }
		guard let imageFilterManager = imageFilterManager else { return }
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
		guard let originImage = originImage else { return Image(image: nil)}
		return originImage
	}

	func filterToImage(indexPath: IndexPath, customParametrs: CustomParameters? = nil, completion: @escaping (Image)->Void){
		guard let imageFilterManager = imageFilterManager else { return }
		guard let resizedImage = resizedImage else { return }
		lastIndex = indexPath
		lastCustomParametrs = customParametrs

		imageFilterManager.apllyFilter(image: resizedImage.image, indexPath: indexPath, customParametrs: customParametrs) { (image) in
			completion(Image(image: image))
		}
	}

	func numberOfRows()-> Int {
		guard let imageFilterManager = imageFilterManager else { return 0 }
		return imageFilterManager.countFilters
	}
	
	func getFilterIcon(indexPath: IndexPath)-> Image {
		guard let imageFilterManager = imageFilterManager else { return Image(image: nil) }
		if let imageIconModel = imageFilterManager.getFiltersIcon(indexPath: indexPath) {
			return imageIconModel
		} else {
			return Image(image: nil)
		}
	}
}
