//
//  CollectionInteractor.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

class CollectionInteractor: CollectionInteractorProtocol {
	
	weak var presenter: CollectionPresenterProtocol!
	let entities = MainEntities()

	init(presenter: CollectionPresenterProtocol) {
		self.presenter = presenter
	}
	func numberOfRows()->Int {
		return entities.urls.count
	}

}
