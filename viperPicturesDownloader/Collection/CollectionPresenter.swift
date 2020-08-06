//
//  CollectionPresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

final class CollectionPresenter: CollectionPresenterProtocol {

	weak var view: CollectionViewProtocol!
	var interactor: CollectionInteractorProtocol!
	var router: CollectionRouterProtocol!

	init(view: CollectionViewProtocol) {
		self.view = view
	}

	func configureView() {
		view.setCollection()
		freeStorage()
//		freeALL()
	}

	func didSelect(indexPath: IndexPath) {
		getImage(indexPath: indexPath, size: ImageSize(size: nil)) { (image) in
			self.router.push(image: image)
		}
	}

	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void) {
		interactor.getImage(indexPath: indexPath, size: size) { (image) in
			completion(image)
		}
	}

	func numberOfRows() ->Int {
		return interactor.numberOfRows()
	}

	private func freeStorage() {
		let date = Calendar.current.date(byAdding: .day, value: -2, to: Date())
		DispatchQueue.global(qos: .background).async {
			self.interactor.freeStorage(befora: date)
		}
	}
	private func freeALL(){
		interactor.freeALL()
	}

	func setUpActivity(viewModel: ViewForActivity) {
		interactor.setUpActivityIndicator(viewModel: viewModel)
	}

	func startActivity() {
		interactor.startActivity()
	}

	func stopActivity() {
		interactor.stopActivity()
	}
}
