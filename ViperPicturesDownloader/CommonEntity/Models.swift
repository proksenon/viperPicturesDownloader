//
//  Models.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 27.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

struct FilterInfo {
	var filter: (UIImage?, CustomParametrs?)->UIImage?
	var imageModel: Image?
	var parametrs: [ParametrInfo]?

}

struct ParametrInfo {
	var startValue: Float
	var	endValue: Float
	var defaultValue: Float
}

struct CustomParametrs {
	var parametrs: [Float]
}

struct Image {
	let image: UIImage?
	var description: String? = ""
	var urlString: String? = ""
}

struct ImageSize {
	var size: CGSize? = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
}

enum ImageFormat {
	case png
	case jpeg
}
