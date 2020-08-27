//
//  MainRouterProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol MainRouterInput: class {
	///  Переходит на CollectionViewController
	func pushCollection(with imageUrls: ImageUrls)
	///  Переходит  на ImageViewController
	func push(image: Image)
}
