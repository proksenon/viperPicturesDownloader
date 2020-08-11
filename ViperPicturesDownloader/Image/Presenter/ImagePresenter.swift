//
//  ImagePresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
/// Презентер экрана с картинкой
class ImagePresenter {

	weak var view: ImageViewInput!
	var interactor: ImageInteractorInput!
	var router: ImageRouterInput!

	init(view: ImageViewInput) {
		self.view = view
	}

}
// MARK: - ImageViewOutput
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
// MARK: - ImageInteractorOuput
extension ImagePresenter: ImageInteractorOuput {}
