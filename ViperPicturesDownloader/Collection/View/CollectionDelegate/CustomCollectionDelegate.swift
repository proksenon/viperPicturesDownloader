//
//  CustomCollectionDelegate.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	var collectionView: CustomCollectionView!
	var output: CollectionViewDelegateOutput!

	init(collectionView: CustomCollectionView, output: CollectionViewDelegateOutput){
		super.init()
		self.collectionView = collectionView
		self.collectionView.delegate = self
		self.output = output
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		output.didSelect(indexPath: indexPath)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 300, height: 600)
	}
}
