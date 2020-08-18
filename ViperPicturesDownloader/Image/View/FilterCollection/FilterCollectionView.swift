//
//  FilterCollectionView.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 17.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class FilterCollectionView: UICollectionView {

	init() {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		super.init(frame: .zero, collectionViewLayout: layout)
		backgroundColor = .clear
		contentInsetAdjustmentBehavior = .always
		showsHorizontalScrollIndicator = false
		layout.minimumLineSpacing = 30
		contentInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
		register(FilterCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	

}
