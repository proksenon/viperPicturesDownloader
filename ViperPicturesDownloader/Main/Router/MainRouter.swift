//
//  MainRouter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
/// Роутер главного экрана
final class MainRouter : MainRouterInput {

	weak var viewController: MainViewController!

	init(viewController: MainViewController) {
		self.viewController = viewController
	}
	/// Переходит  на экран с картинкой
	func push(image: Image) {
		let nextVC = ImageViewController()
		nextVC.image = image.image
		viewController.navigationController?.pushViewController(nextVC, animated: true)
	}
	/// Переходит на коллекш
	func pushCollection() {
		let navigationController = UINavigationController(
            rootViewController: CollectionViewController()
        )
		let nextVC = CollectionViewController()
		viewController.navigationController?.pushViewController(nextVC, animated: true)
	}
}
