//
//  SpotColorFilter.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 01.09.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class SpotColorFilter: ImageFilterProtocol {
	var name: String = "CISpotColor"

	var iconFilter: UIImage? = UIImage(named: "origin")

	var displayName: String? = "Spot"

	var parametrsForSliders: [ParametersForSlider]? = [ParametersForSlider(key: "inputCloseness1", startValue: 0.0, endValue: 1.0, defaultValue: 1),
													   ParametersForSlider(key: "inputCloseness2", startValue: 0.0, endValue: 1.0, defaultValue: 1),
													   ParametersForSlider(key: "inputCloseness3", startValue: 0.0, endValue: 1.0, defaultValue: 1)]

	var defaultParametrs: [FilterParameter]? = [
		FilterParameter(key: "inputCenterColor1", value: CIColor.green),
		FilterParameter(key: "inputReplacementColor1", value: CIColor.red),
		FilterParameter(key: "inputCloseness1", value: 1),
		FilterParameter(key: "inputContrast1", value: 1),

		FilterParameter(key: "inputCenterColor2", value: CIColor.red),
		FilterParameter(key: "inputReplacementColor2", value: CIColor.blue),
		FilterParameter(key: "inputCloseness2", value: 1),
		FilterParameter(key: "inputContrast2", value: 1),

		FilterParameter(key: "inputCenterColor3", value: CIColor.blue),
		FilterParameter(key: "inputReplacementColor3", value: CIColor.green),
		FilterParameter(key: "inputCloseness3", value: 1),
		FilterParameter(key: "inputContrast3", value: 1),

	]

	
}
