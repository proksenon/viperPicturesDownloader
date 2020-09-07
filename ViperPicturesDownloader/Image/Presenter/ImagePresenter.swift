//
//  ImagePresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

/// Презентер экрана с картинкой
final class ImagePresenter {

	weak var view: ImageViewInput?
	var interactor: ImageInteractorInput?
	var router: ImageRouterInput?
	var filterCollectionDataSource: FilterCollectionViewDataSource?
	var filterCollectionDelegate: FilterCollectionViewDelegate?
	private var valuesFromSliders: [String: Any]?
	private var filters: [ImageFilterProtocol]
	private var originImage: ImageModel? {
		didSet {
			guard let originImage = originImage else { return }
			let image = originImage.image?.resizeImage(targetSize: ImageSize().size!)
			resizedImage = ImageModel(image: image)
		}
	}
	private var resizedImage: ImageModel?
	private var lastFilterSettings: FilterSettings?

	init(view: ImageViewInput) {
		self.view = view
		filters = [ WithoutFilter(), SepiaToneFilter(), ColorControlsFilter(), NoirFilter(), EdgesFilter(), GaussianBlurFilter(), PinkCrossPolynomial(), SpotColorFilter()]
	}
	///		Значения фильтра для слайдеров
	private func getParamsForSlider(index: Int) -> [ParametersForSlider]?  {
		return filters[index].getParametrsForSliders()
	}
	///		Настройки фильтра
	private func getFilterSettings(index: Int)-> FilterSettings? {
		return filters[index].getFilterSettings()
	}
}

// MARK: - ImageViewOutput
extension ImagePresenter: ImageViewOutput{

	func configureView() {
		guard let view = view else { return }
		guard let originImage = originImage else { return }

		view.setUpImageView()
		view.configureImageView()
		view.setUpCollection()
		view.constraintCollection()
		view.setImage(with: originImage)
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

		interactor.saveImageToLibrary(imageModel: originImage, filterSettings: lastFilterSettings)
	}

	func filterImage(filterSettings: FilterSettings?) {
		guard let interactor = interactor, let resizedImage = resizedImage else { return }
		guard let view = view else { return }

		interactor.filterToImage(imageModel: resizedImage, filterSettings: filterSettings) { (imageModel) in
			view.setImage(with: imageModel)
		}
	}
	func didChangeFiltersParameters(key: String, value: Any) {
		guard var valuesFromSliders = valuesFromSliders else { return }
		guard let lastFilterParameters = lastFilterSettings else { return }

		valuesFromSliders[key] = value
		self.valuesFromSliders = valuesFromSliders
		var filterParameters: [FilterParameter] = []
		for (key, value) in valuesFromSliders {
			filterParameters.append(FilterParameter(key: key, value: value))
		}
		let fillterSettings = FilterSettings(name: lastFilterParameters.name, parameters: filterParameters)
		self.lastFilterSettings = fillterSettings
		filterImage(filterSettings: fillterSettings)
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
		return filters.count
	}

	func getFilterIcon(indexPath: IndexPath)-> ImageWithDesc {
		let filter = filters[indexPath.row]
		return ImageWithDesc(image: filter.iconFilter, description: filter.displayName)
	}

}
// MARK: - FilterCollectionViewDelegateOutput
extension ImagePresenter: FilterCollectionViewDelegateOutput {

	func newDidSelect(indexPath: IndexPath) {
		if let filterParametersForSlider = getParamsForSlider(index: indexPath.row) {
			valuesFromSliders = [:]
			newSetDefaultValue(filterParametersForSlider: filterParametersForSlider)
			showCollection(countSliders: filterParametersForSlider.count, false)
		}
		let defaultFilterSettings = getFilterSettings(index: indexPath.row)
		lastFilterSettings = defaultFilterSettings
		filterImage(filterSettings: defaultFilterSettings)
	}

	private func newSetDefaultValue(filterParametersForSlider: [ParametersForSlider]) {
		guard let view = view else { return }
		guard var valuesFromSliders = valuesFromSliders else { return }
		for (index, parameter) in filterParametersForSlider.enumerated() {
			print("defValue \(parameter.defaultValue)")
			view.setDefaultValueToSlider(sliderNubmer: index,
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
	func configure(with image: ImageModel?) {
		originImage = image
	}
}
