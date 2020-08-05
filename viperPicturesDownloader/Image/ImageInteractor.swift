//
//  ImageInteractor.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

class ImageInteractor: ImageInteractorProtocol {
	weak var presenter: ImagePresenterProtocol!

	init(presenter: ImagePresenterProtocol) {
		self.presenter = presenter
	}
}
