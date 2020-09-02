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
	var currentFilterName: String?
	var customParameters: NewFilterParameters?
	var valuesFromSliders: [String: Any]?
	private var originImage: Image? {
		didSet {
			guard let originImage = originImage else { return }
			let image = originImage.image?.resizeImage(targetSize: ImageSize().size!)
			resizedImage = Image(image: image)
		}
	}
	private var resizedImage: Image?

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

	func newFilterImage(customParametr: NewFilterParameters?) {
		guard let interactor = interactor else { return }
		guard let view = view else { return }
		guard let indexPath = indexPath else { return }

		interactor.newFilterToImage(index: indexPath.row, parameters: customParametr) { (imageModel) in
			view.setImage(with: imageModel)
		}
	}
	func didChangeFiltersParameters(key: String, value: Any) {
		guard var valuesFromSliders = valuesFromSliders else { return }

		valuesFromSliders[key] = value
		self.valuesFromSliders = valuesFromSliders
		var defParams: [DefParameter] = []
		for (key, value) in valuesFromSliders {
			defParams.append(DefParameter(key: key, value: value))
		}
		newFilterImage(customParametr: NewFilterParameters(name: currentFilterName!, parameters: defParams))
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
		return interactor.newNumberOfRows()
	}

	func getFilterIcon(indexPath: IndexPath)-> Image {
		guard let interactor = interactor else { return Image(image: nil) }
		return interactor.newGetFilterIcon(index: indexPath.row)
	}
}
// MARK: - FilterCollectionViewDelegateOutput
extension ImagePresenter: FilterCollectionViewDelegateOutput {

	func newDidSelect(indexPath: IndexPath) {
		guard let interactor = interactor else { return }
		self.indexPath = indexPath
		if let filterParameters = interactor.getParamsForSlider(index: indexPath.row) {
			valuesFromSliders = [:]
			newSetDefaultValue(filterParametrs: filterParameters)
			let defaultParameters = interactor.getDefaultParameters(index: indexPath.row)
			currentFilterName = defaultParameters?.name
			customParameters = defaultParameters
			newFilterImage(customParametr: defaultParameters)
			showCollection(countSliders: filterParameters.count, false)
		} else {
			let defaultParameters = interactor.getDefaultParameters(index: indexPath.row)
			currentFilterName = defaultParameters?.name
			newFilterImage(customParametr: defaultParameters)
		}
	}

	private func newSetDefaultValue(filterParametrs: [ParametersForSlider]) {
		guard let view = view else { return }
		guard var valuesFromSliders = valuesFromSliders else { return }
		for (index, parameter) in filterParametrs.enumerated() {
			print("defValue \(parameter.defaultValue)")
			view.newSetDefaultValueToSlider(sliderNubmer: index,
											minValue: parameter.startValue,
											maxValue: parameter.endValue,
											defaultValue: parameter.defaultValue,
											identifier: parameter.key)
			valuesFromSliders[parameter.key] = parameter.defaultValue
		}
		self.valuesFromSliders = valuesFromSliders
	}


}

// MARK: - ImageModuleInput
extension ImagePresenter: ImageModuleInput {
	func configure(with image: Image?) {
		originImage = image
	}
}
