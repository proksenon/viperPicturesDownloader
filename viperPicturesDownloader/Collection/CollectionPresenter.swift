//
//  CollectionPresenter.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

class CollectionPresenter: CollectionPresenterProtocol {

	weak var view: CollectionViewProtocol!
	var interactor: CollectionInteractorProtocol!
	var router: CollectionRouterProtocol!

	init(view: CollectionViewProtocol) {
		self.view = view
	}

	func configureView() {
		
	}
}
