//
//  Models.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 27.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

///		Модель данных фильтра картинки
struct FilterInfo {
	var filter: (UIImage?, CustomParametrs?)->UIImage?
	var imageModel: Image?
	var parametrs: [ParametrInfo]?

}
///		Модель параметров фильтра картинки
struct ParametrInfo {
	var startValue: Float
	var	endValue: Float
	var defaultValue: Float
}
///		Модель пользовательских параметров фильтра
struct CustomParametrs {
	var parametrs: [Float]
}
///		Модель картинки
struct Image {
	let image: UIImage?
	var description: String? = ""
	var urlString: String? = ""
}
///		Модель размера картинки
struct ImageSize {
	var size: CGSize? = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
}
///		Формат картинки
enum ImageFormat {
	case png
	case jpeg
}
