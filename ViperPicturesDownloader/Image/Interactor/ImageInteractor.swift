//
//  ImageInteractor.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
/// Интерактор экрана с картиной
final class ImageInteractor: ImageInteractorInput {

	weak var output: ImageInteractorOuput?
	private var imageFilter: ImageFilterManagerProtocol

	init(presenter: ImageInteractorOuput, imageFilter: ImageFilterManagerProtocol = ImageFilterManager()) {
		self.output = presenter
		self.imageFilter = imageFilter
	}

	func saveImageToLibrary(imageModel: ImageModel?, filterSettings: FilterSettings?) {
		guard let imageModel = imageModel else { return }
		if filterSettings != nil {
			filterToImage(imageModel: imageModel, filterSettings: filterSettings) { (imageModel) in
				if let image = imageModel.image {
					UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil)
				}
			}
		} else {
			guard let image = imageModel.image else { return }
			UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil)
		}
	}

	func filterToImage(imageModel: ImageModel, filterSettings: FilterSettings?, completion: @escaping (ImageModel)->Void) {
		DispatchQueue.global().async {
			let filteredImage = self.imageFilter.applyFilter(image: imageModel.image, parameters: filterSettings)
			DispatchQueue.main.async {
				completion(ImageModel(image: filteredImage))
			}
		}

	}
}
