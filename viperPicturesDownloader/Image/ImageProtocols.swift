//
//  ImageProtocols.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol ImageViewProtocol: class {
	func loadImageView()
	func backgroundColor()
	func tapImage()
}

protocol ImagePresenterProtocol: class {
	func configureView()
	func popViewController()
}

protocol ImageInteractorProtocol: class{

}

protocol ImageRouterProtocol: class {
	func pop()
}

protocol ImageConfiguratorProtocol: class {
	func configure(with viewController: ImageViewController)
}
