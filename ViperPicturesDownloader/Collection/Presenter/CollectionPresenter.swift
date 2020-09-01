//
//  CollectionPresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
/// Презентер экрана с колекцией
final class CollectionPresenter {

	weak var view: CollectionViewInput?
	var interactor: CollectionInteractorInput?
	var router: CollectionRouterInput?
	var customCollectionDataSource: CustomCollectionViewDataSource?
	var customCollectionDelegate: CustomCollectionViewDelegate?

	init(view: CollectionViewInput) {
		self.view = view
	}

}
// MARK: - CollectionViewOutput
extension CollectionPresenter: CollectionViewOutput {
	func configureView() {
		guard let view = view else { return }
		view.setCollection()
		view.setCollectionConstraint()
	}
}
// MARK: - CollectionViewDelegateOutput
extension CollectionPresenter: CollectionViewDelegateOutput {
	func didSelect(indexPath: IndexPath) {
		guard let router = router else { return }
		getImage(indexPath: indexPath, size: ImageSize(size: nil)) { (image) in
			router.push(image: image)
		}
	}
}
// MARK: - CollectionViewDataSourceOutput
extension CollectionPresenter: CollectionViewDataSourceOutput {

	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void) {
		guard let interactor = interactor else { return }
		interactor.getImage(index: indexPath.row, size: size) { (image) in
			completion(image)
		}
	}

	func numberOfRows() ->Int {
		guard let interactor = interactor else { return 0 }
		return interactor.numberOfRows()
	}
}
// MARK: - CollectionInteractorOutput
extension CollectionPresenter: CollectionInteractorOutput {
	
}
// MARK: - CollectionModuleInput
extension CollectionPresenter: CollectionModuleInput {
	func configure(with imagesUrl: ImageUrls?) {
		guard let imagesUrl = imagesUrl else { return }
		guard let interactor = interactor else { return }
		interactor.setImageUrls(with: imagesUrl)
	}


}
