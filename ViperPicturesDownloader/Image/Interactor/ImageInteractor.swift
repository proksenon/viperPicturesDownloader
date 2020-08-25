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
//	var filter: ImageFilter!
//	var filters: [(UIImage?)->UIImage?]!
//	var filterImage: UIImage?
//	var effect: Bool = false
	let filtersImages = FiltersIcons()
	var imageFilterManager: ImageFilterManagerProtocol!
	var image: Image!

	init(presenter: ImageInteractorOuput, imageFilterManager: ImageFilterManagerProtocol = ImageFilterManager()) {
		self.presenter = presenter
		self.imageFilterManager = imageFilterManager
	}

	func didSelect(indexPath: IndexPath, customParametrs: CustomParametrs? = nil)-> Image {
		return filterToImage(indexPath: indexPath, customParametrs: customParametrs)
	}

	func getParamsAt(indexPath: IndexPath)->[ParametrInfo]? {
		return imageFilterManager.getParametrs(indexPath: indexPath)
	}

	func originImageSet(image: Image) {
		imageFilterManager.originImage = image.image
	}

	func originImageGet()-> Image {
		return Image(image: imageFilterManager.originImage)
	}
//private
	private func filterToImage(indexPath: IndexPath, customParametrs: CustomParametrs? = nil)->Image {
		let filterImage = imageFilterManager.apllyFilter(indexPath: indexPath, customParametrs: customParametrs)
		return Image(image: filterImage)
	}

	func numberOfRows()-> Int{
		return imageFilterManager.countFilters
	}
	func getFilterIcon(indexPath: IndexPath)->Image {
		filtersImages.images[indexPath.row]
	}
}
