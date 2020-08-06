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
	func setButton()
}

protocol MainPresenterProtocol: class {
	func configureView()
	func pushCollection()
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	func numberOfRows() ->Int
	func didSelect(indexPath: IndexPath)
	func setUpActivity(viewModel: ViewForActivity)
	func startActivity()
	func stopActivity()
}

protocol MainInteractorProtocol: class{
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	func numberOfRows() -> Int
	func freeStorage(befora date: Date?)
	func freeALL()
	func setUpActivityIndicator(viewModel: ViewForActivity)
	func startActivity()
	func stopActivity()
}

protocol MainRouterProtocol: class {
	func pushCollection()
	func push(image: Image)
}

protocol MainConfiguratorProtocol: class {
	func configure(with viewController: MainViewController)
}
