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

	weak var viewController: CollectionViewController?

	init(viewController: CollectionViewController) {
		self.viewController = viewController
	}

	func push(image: Image) {
		let nextVC = ImageViewController()
		let configurator = ImageConfigurator()
		configurator.configure(with: nextVC)
		guard let nextVCModuleInput = nextVC.moduleInput else { return }
		nextVCModuleInput.configure(with: image)
		viewController?.navigationController?.pushViewController(nextVC, animated: true)
	}
}
