//
//  CollectionModuleInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 24.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol CollectionModuleInput: class {
	///  Конфигурирует ссылки картинок
	func configure(with imagesUrl: ImageUrls?)
}
