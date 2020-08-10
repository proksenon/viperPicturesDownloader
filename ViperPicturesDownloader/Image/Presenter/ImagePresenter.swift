//
//  ImagePresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

class ImagePresenter: ImagePresenterProtocol {

	weak var view: ImageViewProtocol!
	var interactor: ImageInteractorProtocol!
	var router: ImageRouterProtocol!

	init(view: ImageViewProtocol) {
		self.view = view
	}

	func configureView() {
		view.loadImageView()
		view.backgroundColor()
		view.tapImage()
	}

	func popViewController() {
		router.pop()
	}

}
