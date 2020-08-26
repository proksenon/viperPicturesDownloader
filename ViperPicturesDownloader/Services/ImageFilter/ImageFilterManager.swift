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
	var filters: [FilterInfo]
	var countFilters: Int!

	var withoutFilter: FilterInfo!
	var sepiaToneFilter: FilterInfo!
	var colorControlsFilter: FilterInfo!
	var edgesFilter: FilterInfo!
	var noirFilter: FilterInfo!
	var gaussianBlurFilter: FilterInfo!
	var pinkCrossPolynomial: FilterInfo!
	var spotColorFilter: FilterInfo!

	init(imageFilter: ImageFilter = ImageFilter()) {
		self.imageFilter = imageFilter

		withoutFilter = FilterInfo(filter: imageFilter.withoutFilter,
								   parametrs: nil)
		sepiaToneFilter = FilterInfo(filter: imageFilter.sepiaToneFilter,
									 parametrs: [ParametrInfo(startValue: 0.0, endValue: 1.0, defaultValue: 0.3)])
		colorControlsFilter = FilterInfo(filter: imageFilter.colorControlsFilter,
										 parametrs: [ParametrInfo(startValue: 0.0, endValue: 1.0, defaultValue: 0.0), 		ParametrInfo(startValue: 0.0, endValue: 100.0, defaultValue: 5.0),
													ParametrInfo(startValue: 0.0, endValue: 1.0, defaultValue: 1.0)])
		edgesFilter = FilterInfo(filter: imageFilter.edgesFilter,
								 parametrs: [ParametrInfo(startValue: 0.0, endValue: 100.0, defaultValue: 20.0)])
		noirFilter = FilterInfo(filter: imageFilter.noirFilter,
								 parametrs: nil)
		gaussianBlurFilter = FilterInfo(filter: imageFilter.gaussianBlurFilter,
										parametrs: [ParametrInfo(startValue: 0.0, endValue: 100.0, defaultValue: 2.5)])
		pinkCrossPolynomial = FilterInfo(filter: imageFilter.pinkCrossPolynomial,
								 parametrs: nil)
		spotColorFilter = FilterInfo(filter: imageFilter.spotColorFilter,
								 parametrs: [ParametrInfo(startValue: 0.0, endValue: 1.0, defaultValue: 1),
											 ParametrInfo(startValue: 0.0, endValue: 1.0, defaultValue: 1),
											 ParametrInfo(startValue: 0.0, endValue: 1.0, defaultValue: 1)])


		filters = [withoutFilter, sepiaToneFilter, colorControlsFilter, edgesFilter, noirFilter, gaussianBlurFilter, pinkCrossPolynomial, spotColorFilter]

		countFilters = filters.count
	}

	func apllyFilter(image: UIImage?, indexPath: IndexPath, customParametrs: CustomParametrs? = nil, completion: @escaping (UIImage?)-> Void) {
		DispatchQueue.global().async {
			let filteredImage = self.filters[indexPath.row].filter(image, customParametrs)
			DispatchQueue.main.async {
				completion(filteredImage)
			}
		}
	}
	func getParametrs(indexPath: IndexPath)-> [ParametrInfo]?{
		return filters[indexPath.row].parametrs
	}

}

struct FilterInfo {
	var filter: (UIImage?, CustomParametrs?)->UIImage?
	var parametrs: [ParametrInfo]?

}

struct ParametrInfo {
	var startValue: Float
	var	endValue: Float
	var defaultValue: Float
}

struct CustomParametrs {
	var parametrs: [Float]
}
