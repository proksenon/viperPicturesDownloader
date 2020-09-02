//
//  SepiaToneFilter.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 01.09.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class SepiaToneFilter: ImageFilterProtocol {

	let name: String = "CISepiaTone"

	var iconFilter: UIImage? = UIImage(named: "sepiaTone")

	let displayName: String? = "Sepia"

	let parametrsForSliders: [ParametersForSlider]? = [ParametersForSlider(key: kCIInputIntensityKey, startValue: 0.0, endValue: 1.0, defaultValue: 0.3)]

	var defaultParametrs: [DefParameter]? = [DefParameter(key: kCIInputIntensityKey, value: 0.3)]

}
