//
//  CollectionConfigurator.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

final class CollectionConfigurator: CollectionConfiguratorProtocol {

	func configure(with viewController: CollectionViewController) {
		let presenter = CollectionPresenter(view: viewController)
		let interactor = CollectionInteractor(presenter: presenter)
		let router = CollectionRouter(viewController: viewController)

		viewController.viewOutput = presenter
		presenter.interactor = interactor
		presenter.router = router

	}

	
}
