//
//  MainPresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//


import Foundation
//import UIKit
/// Презентер главного экрана
final class MainPresenter {

	weak var view: MainViewInput?
	var interactor: MainInteractorInput?
	var router: MainRouterInput?
	var customTableViewDataSource: CustomTableViewDataSource?
	var customTableViewDelegate: CustomTableViewDelegate?

	init(view: MainViewInput) {
		self.view = view
	}
	/// Очищает хранилище, удаляя файлы, которые лежат больше 2 дней
	private func freeStorage() {
		guard let interactor = interactor else { return }
		let date = Calendar.current.date(byAdding: .day, value: -2, to: Date())
		DispatchQueue.global(qos: .background).async {
			interactor.freeStorage(befora: date)
		}
	}
	/// Полностью очищает хранилище
	private func freeALL(){
		guard let interactor = interactor else { return }

		interactor.freeALL()
	}

}
// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {

	func pushCollection() {
		guard let router = router else { return }

		router.pushCollection(with: interactor?.getImageUrls())
	}

	func configureView() {
		guard let interactor = interactor else { return }
		guard let view = view else { return }

		interactor.setImageUrls()
		view.setViewBackgroud()
		view.setTableView()
		view.setTableConstraints()
		view.setSegueToCollectionButton()
		view.setUpNavigationBar()
		view.setStatusBarStyleLight()
		view.setupAlert()
		view.setAddUrlButton()
		freeStorage()
//		freeALL()
	}

	func didAddUrl(urlString: String?) {
		guard let interactor = interactor else { return }
		guard let view = view else { return }

		interactor.didAddUrl(urlString: urlString)
		view.reloadTable()
		scrollTableToLast()
	}

	func presentAlert() {
		guard let view = view else { return }
		view.presentAlert()
	}

	func imageFromLibrary(image: Image) {
		guard let interactor = interactor else { return }
		guard let view = view else { return }

		interactor.setImage(imageModel: image)
		view.reloadTable()
		scrollTableToLast()
	}

	private func scrollTableToLast() {
		guard let view = view else { return }

		let index = numberOfRows() - 1
		guard index > 0 else { return }
		let lastIndexPath = IndexPath(row: index, section: 0)
		view.scrollTableTo(indexPath: lastIndexPath)
	}

}
// MARK: - TableViewDelegateOutput
extension MainPresenter: TableViewDelegateOutput {

	func didSelect(indexPath: IndexPath) {
		guard let interactor = interactor else { return }
		guard let router = router else { return }

		interactor.getImage(index: indexPath.row, size: ImageSize(size: nil)) { [weak router] (image) in
			router?.push(image: image)
		}
	}
	func didDeleteImage(indexPath: IndexPath) {
		guard let interactor = interactor else { return }

		interactor.deleteImage(index: indexPath.row)
	}

}
// MARK: - TableViewDataSourceOutPut
extension MainPresenter: TableViewDataSourceOutPut {

	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void) {
		guard let interactor = interactor else { return }

		interactor.getImage(index: indexPath.row, size: size) { (image) in
			completion(image)
		}
	}

	func numberOfRows() ->Int {
		return interactor?.numberOfRows() ?? 0
	}
}
// MARK: - MainInteractorOutput
extension MainPresenter: MainInteractorOutput {
	
}
