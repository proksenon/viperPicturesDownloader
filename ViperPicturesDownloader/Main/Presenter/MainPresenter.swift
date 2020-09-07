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
	private var imageUrls: ImageUrls?

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
		guard let imageUrls = imageUrls else { return }

		interactor.freeALL(imageUrls: imageUrls)
	}
	///		Обновляет ссылки картинок
	private func updateImageUrls(imageUrls: ImageUrls) {
		guard let interactor = interactor else { return }

		self.imageUrls = imageUrls
		interactor.saveImageUrls(imageUrls: imageUrls)
	}
}
// MARK: - MainViewOutput
extension MainPresenter: MainViewOutput {

	func pushCollection() {
		guard let router = router else { return }
		guard let imageUrls = imageUrls else { return }

		router.pushCollection(with: imageUrls)
	}

	func configureView() {
		guard let interactor = interactor else { return }
		guard let view = view else { return }

		imageUrls = interactor.setImageUrls()
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
		guard let view = view else { return }
		guard var imageUrls = imageUrls else { return }
		guard let url = urlString else { return }

		imageUrls.urls.append(url)
		updateImageUrls(imageUrls: imageUrls)
		view.reloadTable()
		scrollTableToLast()
	}

	func presentAlert() {
		guard let view = view else { return }
		view.presentAlert()
	}

	func imageFromLibrary(imageModel: ImageWithUrl) {
		guard let interactor = interactor else { return }
		guard let view = view else { return }
		guard var imageUrls = imageUrls else { return }

		if let newImageUrl = interactor.setImage(imageModel: imageModel) {
			imageUrls.urls.append(newImageUrl)
			updateImageUrls(imageUrls: imageUrls)
			view.reloadTable()
			scrollTableToLast()
		}
	}

	private func scrollTableToLast() {
		guard let view = view else { return }

		let index = max(numberOfRows() - 1, 0)
		let lastIndexPath = IndexPath(row: index, section: 0)
		view.scrollTableTo(indexPath: lastIndexPath)
	}

}
// MARK: - TableViewDelegateOutput
extension MainPresenter: TableViewDelegateOutput {

	func didSelect(indexPath: IndexPath) {
		guard let interactor = interactor else { return }
		guard let router = router else { return }
		guard let imageUrls = imageUrls else { return }

		interactor.getImage(imageUrl: imageUrls.urls[indexPath.row], size: ImageSize(size: nil)) { [weak router] (image) in
			router?.push(image: image)
		}
	}

	func didDeleteImage(indexPath: IndexPath) {
		guard let interactor = interactor else { return }
		guard var imageUrls = imageUrls else { return }

		let urlDelete = imageUrls.urls[indexPath.row]
		interactor.deleteImage(urlDelete: urlDelete)
		imageUrls.urls.remove(at: indexPath.row)
		updateImageUrls(imageUrls: imageUrls)
	}

}
// MARK: - TableViewDataSourceOutPut
extension MainPresenter: TableViewDataSourceOutPut {

	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (ImageModel)->Void) {
		guard let interactor = interactor else { return }
		guard let imageUrls = imageUrls else { return }

		interactor.getImage(imageUrl: imageUrls.urls[indexPath.row], size: size) { (imageModel) in
			completion(imageModel)
		}
	}

	func numberOfRows() ->Int {
		guard let imageUrls = imageUrls else { return 0}

		return imageUrls.urls.count
	}
}
// MARK: - MainInteractorOutput
extension MainPresenter: MainInteractorOutput {
	
}
