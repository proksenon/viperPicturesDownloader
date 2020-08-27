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

	weak var viewController: UIViewController!

	init(viewController: MainViewController) {
		self.viewController = viewController
	}
	
	func push(image: Image) {
		let nextVC = ImageViewController()
		nextVC.configurator.configure(with: nextVC)
		nextVC.moduleInput.configure(with: image)

		viewController.navigationController?.pushViewController(nextVC, animated: true)
	}

	func pushCollection(with imageUrls: ImageUrls) {
		let nextVC = CollectionViewController()
		nextVC.configurator.configure(with: nextVC)
		nextVC.moduleInput.configure(with: imageUrls)
		viewController.navigationController?.pushViewController(nextVC, animated: true)
	}
}
