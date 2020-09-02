//
//  EdgesFilter.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 01.09.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class EdgesFilter: ImageFilterProtocol {
	var name: String = "CIEdges"

	var iconFilter: UIImage? = UIImage(named: "edges")

	var displayName: String? = "Edges"

	var parametrsForSliders: [ParametersForSlider]? = [ParametersForSlider(key: kCIInputIntensityKey, startValue: 0, endValue: 100, defaultValue: 20)]

	var defaultParametrs: [FilterParameter]? = [FilterParameter(key: kCIInputIntensityKey, value: 20)]

	
}
