//
//  ImageRouter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
/// Роутер экрана с картинкой
class ImageRouter: ImageRouterInput {

	weak var viewController: ImageViewController!

	init(viewController: ImageViewController) {
		self.viewController = viewController
	}
	// Закрывает экран
	func pop() {
		viewController.navigationController?.popViewController(animated: true)
	}
}
