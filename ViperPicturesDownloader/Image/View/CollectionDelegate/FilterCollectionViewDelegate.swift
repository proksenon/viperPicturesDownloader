//
//  FilterCollectionViewDelegate.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 17.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class FilterCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	var collectionView: FilterCollectionView!
	var output: FilterCollectionViewDelegateOutput!
	let filter = ImageFilter()

	init(collectionView: FilterCollectionView, output: FilterCollectionViewDelegateOutput){
		super.init()
		self.collectionView = collectionView
		self.collectionView.delegate = self
		self.output = output
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		output.didSelect(indexPath: indexPath)
		collectionView.cellForItem(at: indexPath)?.isUserInteractionEnabled = false
	}

	func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
		collectionView.cellForItem(at: indexPath)?.isUserInteractionEnabled = true
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: 70, height: 110)
	}
}
