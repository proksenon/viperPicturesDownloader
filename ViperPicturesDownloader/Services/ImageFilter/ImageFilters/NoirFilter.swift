//
//  NoirFilter.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 01.09.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class NoirFilter: ImageFilterProtocol {
	var name: String = "CIPhotoEffectNoir"

	var iconFilter: UIImage? = UIImage(named: "noir")

	var displayName: String? = "Noir"

	var parametrsForSliders: [ParametersForSlider]?

	var defaultParametrs: [FilterParameter]? = []

	
}
