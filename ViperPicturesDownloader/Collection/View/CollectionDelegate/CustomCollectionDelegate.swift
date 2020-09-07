//
//  CustomCollectionDelegate.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

	weak var output: CollectionViewDelegateOutput?

	init(output: CollectionViewDelegateOutput){
		super.init()
		self.output = output
	}

	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let output = output else { return }
		output.didSelect(indexPath: indexPath)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/1.5)
	}
}
