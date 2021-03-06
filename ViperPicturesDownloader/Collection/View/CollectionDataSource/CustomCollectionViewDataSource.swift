//
//  CustomCollectionViewDataSource.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomCollectionViewDataSource: NSObject, UICollectionViewDataSource {

	weak var output: CollectionViewDataSourceOutput?

	init(output: CollectionViewDataSourceOutput){
		super.init()
		self.output = output
	}


	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let output = output else { return 0 }
		return output.numberOfRows()
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let output = output else { return UICollectionViewCell() }
		guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
															for: indexPath) as? CustomCollectionViewCell else { return UICollectionViewCell() }
		let size = CGSize(width: cell.contentView.frame.size.width, height: cell.contentView.frame.size.width)
		cell.currentIndexPath = indexPath
		output.getImage(indexPath: indexPath, size: ImageSize(size: size)) { (image) in
			cell.configureCell(with: image.image, indexPath: indexPath)
		}
		return cell
	}


}
