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

	var indexPath: IndexPath!

	init(view: ImageViewInput) {
		self.view = view
	}

}
// MARK: - ImageViewOutput
extension ImagePresenter: ImageViewOutput{

	func configureView() {
		view.setUpImageView()
		view.configureImageView()
		view.setUpCollection()
		view.constraintCollection()
		view.setImage(with: interactor.originImageGet())
		view.backgroundColor()
		view.setUpSaveButton()
		view.setupSliders()
		view.isHiddenSliders(count: 3, true)
		view.setCancleButton()
		view.isHiddenCancleButton(true)
	}

	func popViewController() {
		router.pop()
	}

	func filterImage(customParametr: CustomParametrs) {
		let filteredImage = interactor.didSelect(indexPath: indexPath, customParametrs: customParametr)
		view.setImage(with: filteredImage)
	}
	func hidenSlidersAndShowCollection() {
		view.isHiddenSliders(count: 3, true)
		view.ishiddenCollection(false)
		view.isHiddenCancleButton(true)
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
		self.indexPath = indexPath
		if let filterParametrs = interactor.getParamsAt(indexPath: indexPath) {
			var parametrs: [Float] = []
			for index in 0..<filterParametrs.count {
				let parametr = filterParametrs[index]
				view.setDefaultValueToSlider(sliderNubme: index, minValue: parametr.startValue , maxValue: parametr.endValue, defaultValue: parametr.defaultValue)
				parametrs.append(parametr.defaultValue)
			}
			let filterImage = interactor.didSelect(indexPath: indexPath, customParametrs: CustomParametrs(parametrs: parametrs))
			view.setImage(with: filterImage)
			view.ishiddenCollection(true)
			view.isHiddenCancleButton(false)
			view.isHiddenSliders(count: filterParametrs.count, false)
		} else {

			let filterImage = interactor.didSelect(indexPath: indexPath, customParametrs: nil)
			view.setImage(with: filterImage)
		}
	}


}

extension ImagePresenter: ImageModuleInput {
	func configure(with image: Image) {
		interactor.originImageSet(image: image)
	}
}
