//
//  ImageModel.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 31.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
protocol ImageModelProtocol {
	var image: UIImage? { get set }
}
///		Модель картинки
struct ImageModel: ImageModelProtocol {
	var image: UIImage?
}

struct ImageWithUrl: ImageModelProtocol {
	var image: UIImage?
	var urlString: String? = ""
}

struct ImageWithDesc: ImageModelProtocol {
	var image: UIImage?
	var description: String? = ""
}
