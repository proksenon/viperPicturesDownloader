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
	var filterCollectionDataSource: FilterCollectionViewDataSource!
	var filterCollectionDelegate: FilterCollectionViewDelegate!
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
		view.setSlidersConstraint()
		view.isHiddenSliders(count: 3, true)
		view.setCancelButton()
		view.setCancelButtonConstraints()
		view.isHiddenCancleButton(true)
	}

	func popViewController() {
		router.pop()
	}

	func saveImageToLibrary() {
		interactor.saveImageToLibrary()
	}
	
	func filterImage(customParametr: CustomParametrs?) {
		interactor.filterToImage(indexPath: indexPath, customParametrs: customParametr) { (imageModel) in
			self.view.setImage(with: imageModel)
		}
	}

	func hidenSlidersAndShowCollection() {
		showCollection(countSliders: 3, true)
	}

	private func showCollection(countSliders: Int, _ isntHidden: Bool) {
		view.isHiddenSliders(count: countSliders, isntHidden)
		view.ishiddenCollection(!isntHidden)
		view.isHiddenCancleButton(isntHidden)
	}
}
// MARK: - ImageInteractorOuput
extension ImagePresenter: ImageInteractorOuput {}

// MARK: - FilterCollectionViewDataSourceOutput
extension ImagePresenter: FilterCollectionViewDataSourceOutput {

	func numberOfRows() -> Int {
		return interactor.numberOfRows()
	}
	func getFilterIcon(indexPath: IndexPath)-> Image {
		return interactor.getFilterIcon(indexPath: indexPath)
	}
}
// MARK: - FilterCollectionViewDelegateOutput
extension ImagePresenter: FilterCollectionViewDelegateOutput {

	func didSelect(indexPath: IndexPath) {
		self.indexPath = indexPath
		if let filterParametrs = interactor.getParamsAt(indexPath: indexPath) {
			let parametrs = setDefaultValue(filterParametrs: filterParametrs)
			filterImage(customParametr: CustomParametrs(parametrs: parametrs))
			showCollection(countSliders: filterParametrs.count, false)
		} else {
			filterImage(customParametr: nil)
		}
	}

	private func setDefaultValue(filterParametrs: [ParametrInfo])-> [Float] {
		var parametrs: [Float] = []
		for index in 0..<filterParametrs.count {
			let parametr = filterParametrs[index]
			view.setDefaultValueToSlider(sliderNubme: index,
										 minValue: parametr.startValue,
										 maxValue: parametr.endValue,
										 defaultValue: parametr.defaultValue)
			parametrs.append(parametr.defaultValue)
		}
		return parametrs
	}


}

// MARK: - ImageModuleInput
extension ImagePresenter: ImageModuleInput {
	func configure(with image: Image) {
		interactor.originImageSet(image: image)
	}
}
