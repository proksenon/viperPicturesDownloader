//
//  CollectionRouterProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol CollectionRouterInput: class {
	///  Переходит  на экран ImageViewController
	func push(image: ImageModel)
}
