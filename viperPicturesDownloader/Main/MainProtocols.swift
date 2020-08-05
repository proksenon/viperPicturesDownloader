//
//  MainProtocols.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

protocol MainViewProtocol: class {
	func setTableView()
}

protocol MainPresenterProtocol: class {
	func configureView()
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	func numberOfRows() ->Int
	func didSelect(indexPath: IndexPath)
}

protocol MainInteractorProtocol: class{
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	func numberOfRows() -> Int
	func freeStorage(befora date: Date?)
	func freeALL()
}

protocol MainRouterProtocol: class {
	func push(image: Image)
}

protocol MainConfiguratorProtocol: class {
	func configure(with viewController: MainViewController)
}
