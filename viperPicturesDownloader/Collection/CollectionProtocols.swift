//
//  CollectionProtocols.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol CollectionViewProtocol: class {
	func setCollection()
}

protocol CollectionPresenterProtocol: class {
	func configureView()
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	func numberOfRows() ->Int
	func didSelect(indexPath: IndexPath)
}

protocol CollectionInteractorProtocol: class{
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	func numberOfRows() -> Int
	func freeStorage(befora date: Date?)
	func freeALL()
}

protocol CollectionRouterProtocol: class {
	func push(image: Image)
}

protocol CollectionConfiguratorProtocol: class {
	func configure(with viewController: CollectionViewController)
}
