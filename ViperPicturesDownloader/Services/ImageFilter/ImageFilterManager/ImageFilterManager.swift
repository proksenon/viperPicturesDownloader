////
////  ImageFilterManager.swift
////  ViperPicturesDownloader
////
////  Created by 18579132 on 18.08.2020.
////  Copyright © 2020 18579132. All rights reserved.
////
//
//import UIKit
//
//class ImageFilterManager: ImageFilterManagerProtocol {
//	let imageFilter: ImageFiltersProtocol
//	var filters: [Filter]
//	var countFilters: Int!
//	var withoutFilter: Filter!
//	var sepiaToneFilter: Filter!
//	var colorControlsFilter: Filter!
//	var edgesFilter: Filter!
//	var noirFilter: Filter!
//	var gaussianBlurFilter: Filter!
//	var pinkCrossPolynomial: Filter!
//	var spotColorFilter: Filter!
//
//	init(imageFilter: ImageFiltersProtocol = ImageFilter()) {
//		self.imageFilter = imageFilter
//
//		withoutFilter = Filter(filter: imageFilter.withoutFilter,
//								   imageModel: Image(image: UIImage(named: "origin"), description: "Origin"),
//								   parametrs: nil)
//
////		sepiaToneFilter = Filter(filter: imageFilter.sepiaToneFilter,
////									 imageModel: Image(image: UIImage(named: "sepiaTone"), description: "Sepia"),
////									 parametrs: [ParametersForSlider(startValue: 0.0, endValue: 1.0, defaultValue: 0.3)])
////
////		colorControlsFilter = Filter(filter: imageFilter.colorControlsFilter,
////										 imageModel: Image(image: UIImage(named: "colorControls"), description: "ColContr"),
////										 parametrs: [ParametersForSlider(startValue: 0.0, endValue: 1.0, defaultValue: 0.0),
////													 ParametersForSlider(startValue: 0.0, endValue: 100.0, defaultValue: 5.0),
////													 ParametersForSlider(startValue: 0.0, endValue: 1.0, defaultValue: 1.0)])
////
////		edgesFilter = Filter(filter: imageFilter.edgesFilter,
////								 imageModel: Image(image: UIImage(named: "edges"), description: "Edges"),
////								 parametrs: [ParametersForSlider(startValue: 0.0, endValue: 100.0, defaultValue: 20.0)])
//
//		noirFilter = Filter(filter: imageFilter.noirFilter,
//								imageModel: Image(image: UIImage(named: "noir"), description: "Noir"),
//								parametrs: nil)
//
////		gaussianBlurFilter = Filter(filter: imageFilter.gaussianBlurFilter,
////										imageModel: Image(image: UIImage(named: "gaussinBlur"), description: "Blur"),
////										parametrs: [ParametersForSlider(startValue: 0.0, endValue: 100.0, defaultValue: 2.5)])
//
//		pinkCrossPolynomial = Filter(filter: imageFilter.pinkCrossPolynomial,
//										 imageModel: Image(image: UIImage(named: "origin"), description: "Colors"),
//										 parametrs: nil)
////
////		spotColorFilter = Filter(filter: imageFilter.spotColorFilter,
////									 imageModel: Image(image: UIImage(named: "origin"), description: "colorSpot"),
////									 parametrs: [ParametersForSlider(startValue: 0.0, endValue: 1.0, defaultValue: 1),
////												 ParametersForSlider(startValue: 0.0, endValue: 1.0, defaultValue: 1),
////												 ParametersForSlider(startValue: 0.0, endValue: 1.0, defaultValue: 1)])
//
//
//		filters = [withoutFilter,
////				   sepiaToneFilter,
////				   colorControlsFilter,
////				   edgesFilter,
//				   noirFilter,
////				   gaussianBlurFilter,
//				   pinkCrossPolynomial,
////				   spotColorFilter
//		]
//		countFilters = filters.count
//	}
//
//	func apllyFilter(image: UIImage?, index: Int, customParametrs: CustomParameters? = nil, completion: @escaping (UIImage?)-> Void) {
//		DispatchQueue.global().async {
//			let filteredImage = self.filters[index].filter(image, customParametrs)
//			DispatchQueue.main.async {
//				completion(filteredImage)
//			}
//		}
//	}
//
//	func getParametrs(index: Int)-> [ParametersForSlider]?{
//		return filters[index].parametrs
//	}
//
//	func getFiltersIcon(index: Int)-> Image? {
//		return filters[index].imageModel
//	}
//
//}
