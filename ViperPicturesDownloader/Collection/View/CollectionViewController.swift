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
	var output: Presenter!
	let configurator: CollectionConfiguratorProtocol = CollectionConfigurator()
	var collectionView: CustomCollectionView!
	var customCollectionDataSource: CustomCollectionViewDataSource!
	var customCollectionDelegate: CustomCollectionViewDelegate!

	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(with: self)
		output.configureView()
	}

}
// MARK: - CollectionViewInput
extension CollectionViewController: CollectionViewInput {
	func setCollection() {
		collectionView = CustomCollectionView()
		view.addSubview(collectionView)
		customCollectionDataSource = CustomCollectionViewDataSource(collectionView: collectionView, presenter: output)
		customCollectionDelegate = CustomCollectionViewDelegate(collectionView: collectionView, presenter: output)
	}

	func setCollectionConstraint() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
			collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
			collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
			collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)
		])
	}
}
