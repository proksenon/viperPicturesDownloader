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
	private var lastCustomParametrs: NewFilterParameters?
	let colorFilter: ImageFilterProtocol = ColorControlsFilter()
	let sepiaToneFilter: ImageFilterProtocol = SepiaToneFilter()
	var filters: [ImageFilterProtocol]!
	let newImageFilter = NewImageFilterManager()

	init(presenter: ImageInteractorOuput) {
		self.presenter = presenter
		filters = [SepiaToneFilter(), ColorControlsFilter(), WithoutFilter(), NoirFilter(), EdgesFilter(), GaussianBlurFilter(), PinkCrossPolynomial(), SpotColorFilter()]
	}

	func getParamsForSlider(index: Int) -> [ParametersForSlider]?  {
		return filters[index].getParametrsForSliders()
	}

	func getDefaultParameters(index: Int)-> NewFilterParameters? {
		return filters[index].getParametersForFilter()
	}
//
	func originImageSet(image: Image) {
		originImage = image
	}

	func saveImageToLibrary() {
//		guard let originImage = originImage else { return }
//		guard let imageFilterManager = imageFilterManager else { return }
//		guard let index = lastIndex else {
//			guard let image = originImage.image else {return}
//			UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil)
//			return
//		}
//
//		imageFilterManager.apllyFilter(image: originImage.image, index: index, customParametrs: lastCustomParametrs) { (image) in
//			if let image = image {
//				UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil)
//			}
//		}
	}

	func originImageGet()-> Image {
		guard let originImage = originImage else { return Image(image: nil)}
		return originImage
	}

	func newFilterToImage(index: Int, parameters: NewFilterParameters?, completion: @escaping (Image)->Void) {
//		lastIndex = index
//		lastCustomParametrs = parameters
		DispatchQueue.global().async {
			let filteredImage = self.newImageFilter.applyFilter(image: self.resizedImage?.image, parameters: parameters)
			DispatchQueue.main.async {
				completion(Image(image: filteredImage))
			}
		}

	}

	func newNumberOfRows() -> Int {
		return filters.count
	}

	func newGetFilterIcon(index: Int)-> Image {
		Image(image: filters[index].iconFilter, description: filters[index].displayName)
	}
}
