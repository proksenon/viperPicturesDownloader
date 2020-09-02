//
//  GaussianBlurFilter.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 01.09.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class GaussianBlurFilter: ImageFilterProtocol {
	var name: String = "CIGaussianBlur"

	var iconFilter: UIImage? = UIImage(named: "gaussinBlur")

	var displayName: String? = "Blur"

	var parametrsForSliders: [ParametersForSlider]? = [ParametersForSlider(key: kCIInputRadiusKey, startValue: 0, endValue: 100, defaultValue: 2.5)]

	var defaultParametrs: [FilterParameter]? = [FilterParameter(key: kCIInputRadiusKey, value: 2.5)]

}
