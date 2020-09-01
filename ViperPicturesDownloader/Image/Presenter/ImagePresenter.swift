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

	weak var view: ImageViewInput?
	var interactor: ImageInteractorInput?
	var router: ImageRouterInput?
	var filterCollectionDataSource: FilterCollectionViewDataSource?
	var filterCollectionDelegate: FilterCollectionViewDelegate?
	private var indexPath: IndexPath?

	init(view: ImageViewInput) {
		self.view = view
	}
}

// MARK: - ImageViewOutput
extension ImagePresenter: ImageViewOutput{

	func configureView() {
		guard let view = view else { return }
		guard let interactor = interactor else { return }

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
		guard let router = router else { return }

		router.pop()
	}

	func saveImageToLibrary() {
		guard let interactor = interactor else { return }

		interactor.saveImageToLibrary()
	}
	
	func filterImage(customParametr: CustomParameters?) {
		guard let interactor = interactor else { return }
		guard let view = view else { return }
		guard let indexPath = indexPath else { return }

		interactor.filterToImage(indexPath: indexPath, customParametrs: customParametr) { (imageModel) in
			view.setImage(with: imageModel)
		}
	}

	func hidenSlidersAndShowCollection() {
		showCollection(countSliders: 3, true)
	}

	private func showCollection(countSliders: Int, _ isntHidden: Bool) {
		guard let view = view else { return }
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
		guard let interactor = interactor else { return 0 }
		return interactor.numberOfRows()
	}
	func getFilterIcon(indexPath: IndexPath)-> Image {
		guard let interactor = interactor else { return Image(image: nil) }
		return interactor.getFilterIcon(indexPath: indexPath)
	}
}
// MARK: - FilterCollectionViewDelegateOutput
extension ImagePresenter: FilterCollectionViewDelegateOutput {

	func didSelect(indexPath: IndexPath) {
		guard let interactor = interactor else { return }
		self.indexPath = indexPath
		if let filterParametrs = interactor.getParamsAt(indexPath: indexPath) {
			let parametrs = setDefaultValue(filterParametrs: filterParametrs)
			filterImage(customParametr: CustomParameters(parameters: parametrs))
			showCollection(countSliders: filterParametrs.count, false)
		} else {
			filterImage(customParametr: nil)
		}
	}

	private func setDefaultValue(filterParametrs: [DefaultParameters])-> [Float] {
		guard let view = view else { return [] }
		var parametrs: [Float] = []
		for index in 0..<filterParametrs.count {
			let parametr = filterParametrs[index]
			view.setDefaultValueToSlider(sliderNubmer: index,
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
	func configure(with image: Image?) {
		guard let interactor = interactor else { return }
		guard let image = image else { return }
		interactor.originImageSet(image: image)
	}
}
