//
//  ImageModuleInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 18.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol ImageModuleInput: class {
	///  Устанавливает входящую картинку
	func configure(with image: Image?)
}
