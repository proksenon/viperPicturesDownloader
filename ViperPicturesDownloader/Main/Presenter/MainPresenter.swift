//
//  MainPresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//


import Foundation
/// Презентер главного экрана
final class MainPresenter {

	weak var view: MainViewInput!
	var interactor: MainInteractorInput!
	var router: MainRouterInput!

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
		router.pushCollection()
	}

	func configureView() {
		interactor.getImageUrls()
		view.setTableView()
		view.setTableConstraints()
		view.setButton()
		view.setUpNavigationBar()
		view.setStatusBarStyleLight()
		view.setupAlert()
		view.setAddUrlButton()
		//freeStorage()
		//freeALL()
	}

	func didAddUrl(urlString: String?) {
		interactor.didAddUrl(urlString: urlString)
		view.reloadTable()
	}

	func presentAlert() {
		view.presentAlert()
	}
}
// MARK: - TableViewDelegateOutput
extension MainPresenter: TableViewDelegateOutput {

	func didSelect(indexPath: IndexPath) {
		getImage(indexPath: indexPath, size: ImageSize(size: nil)) { (image) in
			self.router.push(image: image)
		}
	}

}
// MARK: - TableViewDataSourceOutPut
extension MainPresenter: TableViewDataSourceOutPut {

	func setUpActivity(viewModel: ViewForActivity) {
		interactor.setUpActivityIndicator(viewModel: viewModel)
	}

	func startActivity() {
		interactor.startActivity()
	}

	func stopActivity() {
		interactor.stopActivity()
	}

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
