//
//  ImagePresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
/// Презентер экрана с картинкой
class ImagePresenter {

	weak var view: ImageViewInput!
	var interactor: ImageInteractorInput!
	var router: ImageRouterInput!

	init(view: ImageViewInput) {
		self.view = view
	}

}
// MARK: - ImageViewOutput
extension ImagePresenter: ImageViewOutput{

	func configureView() {
		//view.loadImageView()

		view.setUpImageView()
		view.configureImageView()
		view.setUpCollection()
		view.constraintCollection()
		view.setImage(with: interactor.originImageGet())

		view.backgroundColor()
		view.tapImage()
	}

	func popViewController() {
		router.pop()
	}

	func filterImage() {
		let filteredImage = interactor.filterToImage(indexPath: IndexPath(row: 1, section: 1))
		view.setImage(with: filteredImage)
	}
}
// MARK: - ImageInteractorOuput
extension ImagePresenter: ImageInteractorOuput {}

extension ImagePresenter: FilterCollectionViewDataSourceOutput {

	func numberOfRows() -> Int {
		return interactor.numberOfRows()
	}
	func getFilterIcon(indexPath: IndexPath)-> Image {
		return interactor.getFilterIcon(indexPath: indexPath)
	}
}

extension ImagePresenter: FilterCollectionViewDelegateOutput {

	func didSelect(indexPath: IndexPath) {
		let filterImage = interactor.didSelect(indexPath: indexPath)
		view.setImage(with: filterImage)
	}


}

extension ImagePresenter: ImageModuleInput {
	func configure(with image: Image) {
		interactor.originImageSet(image: image)
	}
}
