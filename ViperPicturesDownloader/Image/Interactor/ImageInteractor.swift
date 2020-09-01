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
	private var imageFilterManager: ImageFilterManagerProtocol?
	private var originImage: Image? {
		didSet {
			guard let originImage = originImage else { return }
			let image = originImage.image?.resizeImage(targetSize: ImageSize().size!)
			resizedImage = Image(image: image)
		}
	}
	private var resizedImage: Image?
	private var lastIndex: Int?
	private var lastCustomParametrs: CustomParameters?

	init(presenter: ImageInteractorOuput, imageFilterManager: ImageFilterManagerProtocol = ImageFilterManager()) {
		self.presenter = presenter
		self.imageFilterManager = imageFilterManager
	}

	func getParamsAt(index: Int)->[DefaultParameters]? {
		guard let imageFilterManager = imageFilterManager else { return nil}
		return imageFilterManager.getParametrs(index: index)
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

		imageFilterManager.apllyFilter(image: originImage.image, index: index, customParametrs: lastCustomParametrs) { (image) in
			if let image = image {
				UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil)
			}
		}
	}

	func originImageGet()-> Image {
		guard let originImage = originImage else { return Image(image: nil)}
		return originImage
	}

	func filterToImage(index: Int, customParametrs: CustomParameters? = nil, completion: @escaping (Image)->Void){
		guard let imageFilterManager = imageFilterManager else { return }
		guard let resizedImage = resizedImage else { return }
		lastIndex = index
		lastCustomParametrs = customParametrs

		imageFilterManager.apllyFilter(image: resizedImage.image, index: index, customParametrs: customParametrs) { (image) in
			completion(Image(image: image))
		}
	}

	func numberOfRows()-> Int {
		guard let imageFilterManager = imageFilterManager else { return 0 }
		return imageFilterManager.countFilters
	}
	
	func getFilterIcon(index: Int)-> Image {
		guard let imageFilterManager = imageFilterManager else { return Image(image: nil) }
		if let imageIconModel = imageFilterManager.getFiltersIcon(index: index) {
			return imageIconModel
		} else {
			return Image(image: nil)
		}
	}
}
