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

	var output: CollectionViewOutput!
	var moduleInput: CollectionModuleInput!
	let configurator: CollectionConfiguratorProtocol = CollectionConfigurator()
	var collectionView: UICollectionView!

	override func viewDidLoad() {
		super.viewDidLoad()
		output.configureView()
	}

}
// MARK: - CollectionViewInput
extension CollectionViewController: CollectionViewInput {
	func setCollection() {
		view.addSubview(collectionView)
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
