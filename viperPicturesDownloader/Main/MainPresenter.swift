//
//  MainPresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//


import Foundation

class MainPresenter: MainPresenterProtocol{

	weak var view: MainViewProtocol!
	var interactor: MainInteractorProtocol!
	var router: MainRouterProtocol!

	init(view: MainViewProtocol) {
		self.view = view
	}

	func configureView() {
		view.setTableView()
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
}
