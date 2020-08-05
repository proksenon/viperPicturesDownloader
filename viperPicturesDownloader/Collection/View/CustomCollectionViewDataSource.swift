//
//  CustomCollectionViewDataSource.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class CustomCollectionViewDataSource: NSObject, UICollectionViewDataSource {

	var collectionView: CustomCollectionView!
	var presenter: CollectionPresenterProtocol!

	init(collectionView: CustomCollectionView, presenter: CollectionPresenterProtocol){
		super.init()
		self.collectionView = collectionView
		self.collectionView.dataSource = self
		self.presenter = presenter
	}


	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		<#code#>
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		<#code#>
	}


}
