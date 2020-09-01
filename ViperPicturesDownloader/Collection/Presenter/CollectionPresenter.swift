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

	weak var view: CollectionViewInput!
	var interactor: CollectionInteractorInput!
	var router: CollectionRouterInput!
	var customCollectionDataSource: CustomCollectionViewDataSource!
	var customCollectionDelegate: CustomCollectionViewDelegate!

	init(view: CollectionViewInput) {
		self.view = view
	}

}
// MARK: - CollectionViewOutput
extension CollectionPresenter: CollectionViewOutput {
	func configureView() {
		view.setCollection()
		view.setCollectionConstraint()
	}
}
// MARK: - CollectionViewDelegateOutput
extension CollectionPresenter: CollectionViewDelegateOutput {
	func didSelect(indexPath: IndexPath) {
		getImage(indexPath: indexPath, size: ImageSize(size: nil)) { (image) in
			self.router.push(image: image)
		}
	}
}
// MARK: - CollectionViewDataSourceOutput
extension CollectionPresenter: CollectionViewDataSourceOutput {

	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void) {
		interactor.getImage(indexPath: indexPath, size: size) { (image) in
			completion(image)
		}
	}

	func numberOfRows() ->Int {
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
		interactor.setImageUrls(with: imagesUrl)
	}


}
