//
//  CustomCollectionView.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomCollectionView: UICollectionView {

	let flowLayout = ZoomAndSnapFlowLayout()

	init() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		super.init(frame: .zero, collectionViewLayout: layout)
		backgroundColor = .white
		collectionViewLayout = flowLayout
		contentInsetAdjustmentBehavior = .always
		showsHorizontalScrollIndicator = false
		register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
//		layout.minimumLineSpacing = 50
//		contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	func setCollectionViewConstraints(collectionViewController: CollectionViewController){
		translatesAutoresizingMaskIntoConstraints = false
		collectionViewController.view.addSubview(self)
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: collectionViewController.view.topAnchor, constant: 0),
			bottomAnchor.constraint(equalTo:collectionViewController.view.bottomAnchor, constant: 0),
			leftAnchor.constraint(equalTo: collectionViewController.view.leftAnchor, constant: 0),
			rightAnchor.constraint(equalTo: collectionViewController.view.rightAnchor, constant: 0)
		])
	}
}
