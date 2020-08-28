//
//  ImageConfigurator.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
/// Конфигуратор
class ImageConfigurator: ImageConfiguratorProtocol {

	func configure(with viewController: ImageViewController) {
		let presenter = ImagePresenter(view: viewController)
		let interactor = ImageInteractor(presenter: presenter)
		let router = ImageRouter(viewController: viewController)

		let filterCollectionView = FilterCollectionView()
		let filterCollectionDelegate = FilterCollectionViewDelegate(output: presenter)
		let filterCollectionDataSorce = FilterCollectionViewDataSource(output: presenter)

		viewController.outputView = presenter
		viewController.moduleInput = presenter
		presenter.interactor = interactor
		presenter.router = router

		presenter.filterCollectionDelegate = filterCollectionDelegate
		presenter.filterCollectionDataSource = filterCollectionDataSorce
		filterCollectionView.delegate = filterCollectionDelegate
		filterCollectionView.dataSource = filterCollectionDataSorce
		viewController.collectionView = filterCollectionView
	}

}
