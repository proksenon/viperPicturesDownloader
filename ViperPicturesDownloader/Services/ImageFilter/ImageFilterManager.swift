//
//  ImageFilterManager.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 18.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class ImageFilterManager: ImageFilterManagerProtocol {
	let imageFilter: ImageFilter
	var filters: [(UIImage?)->UIImage?]
	var originImage: UIImage?
	var filterImage: UIImage?
	var countFilters: Int!

	init(imageFilter: ImageFilter = ImageFilter()) {
		self.imageFilter = imageFilter
		filters = [imageFilter.withoutFilter, imageFilter.sepiaToneFilter, imageFilter.colorControlsFilter, imageFilter.edgesFilter, imageFilter.noirFilter, imageFilter.gaussianBlurFilter]
		countFilters = filters.count
	}

	func apllyFilter(indexPath: IndexPath)-> UIImage? {
		filterImage = filters[indexPath.row](originImage)
		return filterImage
	}

}
