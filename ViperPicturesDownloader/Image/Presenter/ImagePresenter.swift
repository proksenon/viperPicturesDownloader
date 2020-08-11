//
//  ImagePresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

class ImagePresenter {

	weak var view: ImageViewInput!
	var interactor: ImageInteractorInput!
	var router: ImageRouterInput!

	init(view: ImageViewInput) {
		self.view = view
	}

}

extension ImagePresenter: ImageViewOutput{

	func configureView() {
		view.loadImageView()
		view.backgroundColor()
		view.tapImage()
	}

	func popViewController() {
		router.pop()
	}
}

extension ImagePresenter: ImageInteractorOuput {}
