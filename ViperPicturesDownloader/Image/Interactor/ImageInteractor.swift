//
//  ImageInteractor.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

class ImageInteractor: ImageInteractorInput {
	weak var presenter: ImageInteractorOuput!

	init(presenter: ImageInteractorOuput) {
		self.presenter = presenter
	}
}
