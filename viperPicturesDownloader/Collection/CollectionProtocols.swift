//
//  CollectionProtocols.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol CollectionViewProtocol: class {

}

protocol CollectionPresenterProtocol: class {
	func configureView()
}

protocol CollectionInteractorProtocol: class{
	func numberOfRows()->Int
}

protocol CollectionRouterProtocol: class {
	func push(image: Image)
}

protocol CollectionConfiguratorProtocol: class {
	func configure(with viewController: CollectionViewController)
}
