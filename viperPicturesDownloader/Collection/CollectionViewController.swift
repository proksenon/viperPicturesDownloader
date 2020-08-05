//
//  CollectionViewController.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, CollectionViewProtocol {
	
	var presenter: CollectionPresenterProtocol!
	let configurator: CollectionConfiguratorProtocol = CollectionConfigurator()
	var collectionView: CustomCollectionView!
	var customCollectionDataSource: CustomCollectionViewDataSource!
	var customCollectionDelegate: CustomCollectionViewDelegate!

	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(with: self)
		presenter.configureView()
	}

	func setCollection() {
		collectionView = CustomCollectionView()
		collectionView.setCollectionViewConstraints(collectionViewController: self)
		customCollectionDataSource = CustomCollectionViewDataSource(collectionView: collectionView, presenter: presenter)
		customCollectionDelegate = CustomCollectionViewDelegate(collectionView: collectionView, presenter: presenter)
	}

}
