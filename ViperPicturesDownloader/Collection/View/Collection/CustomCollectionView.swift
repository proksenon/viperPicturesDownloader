//
//  CustomCollectionView.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomCollectionView: UICollectionView {

	private let flowLayout = ZoomAndSnapFlowLayout()

	init() {
//		let layout = UICollectionViewFlowLayout()
//		layout.scrollDirection = .horizontal
		super.init(frame: .zero, collectionViewLayout: flowLayout)
		backgroundColor = .gray
		contentInsetAdjustmentBehavior = .always
		showsHorizontalScrollIndicator = false
		register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	func setCollectionViewConstraints(collectionViewController: CollectionViewController){
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: collectionViewController.view.topAnchor, constant: 0),
			bottomAnchor.constraint(equalTo:collectionViewController.view.bottomAnchor, constant: 0),
			leftAnchor.constraint(equalTo: collectionViewController.view.leftAnchor, constant: 0),
			rightAnchor.constraint(equalTo: collectionViewController.view.rightAnchor, constant: 0)
		])
	}
}
