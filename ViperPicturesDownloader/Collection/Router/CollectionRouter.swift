//
//  CollectionRouter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
/// Роутер экрана с колекцией
final class CollectionRouter: CollectionRouterInput {

	weak var viewController: CollectionViewController!

	init(viewController: CollectionViewController) {
		self.viewController = viewController
	}
	/// Переходит  на экран с картинкой
	func push(image: Image) {
		let nextVC = ImageViewController()
				nextVC.configurator.configure(with: nextVC)
				nextVC.moduleInput.configure(with: image)
		//		let nextVC = ImageViewController()
		//		nextVC.image = image.image
				viewController.navigationController?.pushViewController(nextVC, animated: true)
	}
}
