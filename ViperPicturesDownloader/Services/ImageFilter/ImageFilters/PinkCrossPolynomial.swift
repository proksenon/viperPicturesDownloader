//
//  PinkCrossPolynomial.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 01.09.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class PinkCrossPolynomial: ImageFilterProtocol {
	var name: String = "CIColorCrossPolynomial"

	var iconFilter: UIImage? = UIImage(named: "origin")

	var displayName: String? = "Colors"

	var parametrsForSliders: [ParametersForSlider]?

	var defaultParametrs: [DefParameter]? = [
		DefParameter(key: "inputRedCoefficients", value: CIVector(values: [1, 1, 0, 0, 0, 0, 0, 0, 0, 0], count: 10)),
		DefParameter(key: "inputGreenCoefficients", value: CIVector(values: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0], count: 10)),
		DefParameter(key: "inputBlueCoefficients", value: CIVector(values: [1, 0, 1, 0, 0, 0, 0, 0, 0, 0], count: 10))]

	
}
