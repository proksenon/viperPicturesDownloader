//
//  WithoutFilter.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 01.09.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class WithoutFilter: ImageFilterProtocol {
	var name: String = "origin"

	var iconFilter: UIImage? = UIImage(named: "origin")

	var displayName: String? = "Origin"

	var parametrsForSliders: [ParametersForSlider]?

	var defaultParametrs: [FilterParameter]?

}
