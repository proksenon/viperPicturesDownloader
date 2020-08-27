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
		///  Конфигурация модуля
		let presenter = MainPresenter(view: viewController)
		let interactor = MainInteractor(presenter: presenter)
		let router = MainRouter(viewController: viewController)
		///  Таблица
		let customTableViewDelegate = CustomTableViewDelegate(output: presenter)
		let customTableViewDataSource = CustomTableViewDataSource(output: presenter)
		let customTableView = CustomTableView()
		///  Конфигурация модуля
		viewController.output = presenter
		presenter.interactor = interactor
		presenter.router = router
		///  Таблица
		presenter.customTableViewDelegate = customTableViewDelegate
		presenter.customTableViewDataSource = customTableViewDataSource
		customTableView.delegate = customTableViewDelegate
		customTableView.dataSource = customTableViewDataSource
		viewController.tableView = customTableView
	}
}
