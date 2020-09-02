//
//  ImageFilterProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 01.09.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

protocol ImageFilterProtocol {
	var name: String { get }
	var iconFilter: UIImage? { get set }
	var displayName: String? { get }
	var parametrsForSliders: [ParametersForSlider]? { get }
	var defaultParametrs: [FilterParameter]? { get }
}

extension ImageFilterProtocol {
	func getParametrsForSliders() -> [ParametersForSlider]? {
		return parametrsForSliders
	}

	func getFilterSettings() -> FilterSettings {
		return FilterSettings(name: name, parameters: defaultParametrs)
	}
}
