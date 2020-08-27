//
//  CollectionConfigurator.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
/// Конфигуратор экрана с колекцией
final class CollectionConfigurator: CollectionConfiguratorProtocol {

	func configure(with viewController: CollectionViewController) {
		let presenter = CollectionPresenter(view: viewController)
		let interactor = CollectionInteractor(presenter: presenter)
		let router = CollectionRouter(viewController: viewController)
		let customCollectionDelegate = CustomCollectionViewDelegate(output: presenter)
		let customCollectionDataSource = CustomCollectionViewDataSource(output: presenter)
		let customCollectionView = CustomCollectionView()

		viewController.output = presenter
		viewController.moduleInput = presenter
		presenter.interactor = interactor
		presenter.router = router

		presenter.customCollectionDelegate = customCollectionDelegate
		presenter.customCollectionDataSource = customCollectionDataSource
		customCollectionView.delegate = customCollectionDelegate
		customCollectionView.dataSource = customCollectionDataSource
		viewController.collectionView = customCollectionView
	}

	
}
