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

	weak var viewController: UIViewController?

	init(viewController: MainViewController) {
		self.viewController = viewController
	}
	
	func push(image: ImageModel) {
		let nextVC = ImageViewController()
		let configurator = ImageConfigurator()
		configurator.configure(with: nextVC)
		guard let nextVCModuleInput = nextVC.moduleInput else { return }
		nextVCModuleInput.configure(with: image)
		nextVC.modalPresentationStyle = .fullScreen
		nextVC.previousController = viewController
		viewController?.navigationController?.delegate = viewController as? UINavigationControllerDelegate
		viewController?.navigationController?.pushViewController(nextVC, animated: true)
	}

	func pushCollection(with imageUrls: ImageUrls?) {
		let nextVC = CollectionViewController()
		let configurator = CollectionConfigurator()
		configurator.configure(with: nextVC)
		guard let nextVCModuleInput = nextVC.moduleInput else {return}
		nextVCModuleInput.configure(with: imageUrls)
		viewController?.navigationController?.delegate = nil
		viewController?.navigationController?.pushViewController(nextVC, animated: true)
	}
}
