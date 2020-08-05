//
//  CustomCollectionDelegate.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class CustomCollectionViewDelegate: NSObject, UICollectionViewDelegate {

	var collectionView: CustomCollectionView!
	var presenter: CollectionPresenterProtocol!

	init(collectionView: CustomCollectionView, presenter: CollectionPresenterProtocol){
		super.init()
		self.collectionView = collectionView
		self.collectionView.delegate = self
		self.presenter = presenter
	}

}
