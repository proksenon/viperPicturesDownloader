//
//  MainConfigurator.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

final class MainConfigurator : MainConfiguratorProtocol {

	func configure(with viewController: MainViewController) {
		let presenter = MainPresenter(view: viewController)
		let interactor = MainInteractor(presenter: presenter)
		let router = MainRouter(viewController: viewController)
		
		viewController.presenter = presenter
		presenter.interactor = interactor
		presenter.router = router
		
	}
}
