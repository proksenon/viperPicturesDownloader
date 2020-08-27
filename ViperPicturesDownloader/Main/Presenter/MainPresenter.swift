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

	weak var view: MainViewInput!
	var interactor: MainInteractorInput!
	var router: MainRouterInput!
	var customTableViewDataSource: CustomTableViewDataSource!
	var customTableViewDelegate: CustomTableViewDelegate!

	init(view: MainViewInput) {
		self.view = view
	}
	/// Очищает хранилище, удаляя файлы, которые лежат больше 2 дней
	private func freeStorage() {
		let date = Calendar.current.date(byAdding: .day, value: -2, to: Date())
		DispatchQueue.global(qos: .background).async {
			self.interactor.freeStorage(befora: date)
		}
	}
	/// Полностью очищает хранилище
	private func freeALL(){
		interactor.freeALL()
	}

}
// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {

	func pushCollection() {
		router.pushCollection(with: interactor.getImageUrls())
	}

	func configureView() {
		interactor.setImageUrls()
		view.setTableView()
		view.setTableConstraints()
		view.reloadTable()
		view.setSegueToCollectionButton()
		view.setUpNavigationBar()
		view.setStatusBarStyleLight()
		view.setupAlert()
		view.setAddUrlButton()
		freeStorage()
//		freeALL()
	}

	func didAddUrl(urlString: String?) {
		interactor.didAddUrl(urlString: urlString)
		view.reloadTable()
		scrollTableToLast()
	}

	func presentAlert() {
		view.presentAlert()
	}

	func imageFromLibrary(image: Image) {
		interactor.setImage(imageModel: image)
		view.reloadTable()
		scrollTableToLast()
	}

	private func scrollTableToLast() {
		let lastIndexPath = IndexPath(row: numberOfRows() - 1, section: 0)
		view.scrollTableTo(indexPath: lastIndexPath)
	}

}
// MARK: - TableViewDelegateOutput
extension MainPresenter: TableViewDelegateOutput {

	func didSelect(indexPath: IndexPath) {
		interactor.getImage(indexPath: indexPath, size: ImageSize(size: nil)) { [weak self] (image) in
			self?.router.push(image: image)
		}
	}
	func didDeleteImage(indexPath: IndexPath) {
		interactor.deleteImage(indexPath: indexPath)
	}

}
// MARK: - TableViewDataSourceOutPut
extension MainPresenter: TableViewDataSourceOutPut {

	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void) {
		interactor.getImage(indexPath: indexPath, size: size) { (image) in
			completion(image)
		}
	}

	func numberOfRows() ->Int {
		return interactor.numberOfRows()
	}
}
// MARK: - MainInteractorOutput
extension MainPresenter: MainInteractorOutput {
	
}
