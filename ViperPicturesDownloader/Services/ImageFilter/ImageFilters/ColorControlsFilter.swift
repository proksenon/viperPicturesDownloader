//
//  ColorControlsFilter.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 01.09.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class ColorControlsFilter: ImageFilterProtocol {

	var name: String = "CIColorControls"

	var iconFilter: UIImage? = UIImage(named: "colorControls")

	var displayName: String? = "ColContr"

	var parametrsForSliders: [ParametersForSlider]? = [
														ParametersForSlider(key: kCIInputBrightnessKey, startValue: 0.0, endValue: 1.0, defaultValue: 0.0),
													   ParametersForSlider(key: kCIInputSaturationKey, startValue: 0.0, endValue: 100.0, defaultValue: 5.0),
													   ParametersForSlider(key: kCIInputContrastKey, startValue: 0.0, endValue: 1.0, defaultValue: 1.0)]

	var defaultParametrs: [FilterParameter]? = [FilterParameter(key: kCIInputBrightnessKey, value: 0.0),
											 FilterParameter(key: kCIInputSaturationKey, value: 5.0),
											 FilterParameter(key: kCIInputContrastKey, value: 1.0)]
	
}
