//
//  CollectionViewController.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
// View экрана с колекцией
final class CollectionViewController: UIViewController {

	typealias Presenter = CollectionViewOutput & CollectionViewDataSourceOutput & CollectionViewDelegateOutput
	var viewOutput: Presenter!
	let configurator: CollectionConfiguratorProtocol = CollectionConfigurator()
	var collectionView: CustomCollectionView!
	var customCollectionDataSource: CustomCollectionViewDataSource!
	var customCollectionDelegate: CustomCollectionViewDelegate!

	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(with: self)
		viewOutput.configureView()
	}

}
// MARK: - CollectionViewInput
extension CollectionViewController: CollectionViewInput {
	func setCollection() {
		collectionView = CustomCollectionView()
		view.addSubview(collectionView)
		collectionView.setCollectionViewConstraints(collectionViewController: self)
		customCollectionDataSource = CustomCollectionViewDataSource(collectionView: collectionView, presenter: viewOutput)
		customCollectionDelegate = CustomCollectionViewDelegate(collectionView: collectionView, presenter: viewOutput)
	}
}
