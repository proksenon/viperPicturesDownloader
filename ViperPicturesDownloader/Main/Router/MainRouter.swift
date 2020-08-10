//
//  MainRouter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class MainRouter : MainRouterProtocol {

	weak var viewController: MainViewController!

	init(viewController: MainViewController) {
		self.viewController = viewController
	}

	func push(image: Image) {
		let nextVC = ImageViewController()
		nextVC.image = image.image
		viewController.navigationController?.pushViewController(nextVC, animated: true)
	}

	func pushCollection() {
		let navigationController = UINavigationController(
            rootViewController: CollectionViewController()
        )
		let nextVC = CollectionViewController()
		viewController.navigationController?.pushViewController(nextVC, animated: true)
	}
}
