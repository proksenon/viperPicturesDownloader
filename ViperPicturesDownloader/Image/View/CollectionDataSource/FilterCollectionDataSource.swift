//
//  FilterCollectionDataSource.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 17.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class FilterCollectionViewDataSource: NSObject, UICollectionViewDataSource {

	weak var output: FilterCollectionViewDataSourceOutput?

	init(output: FilterCollectionViewDataSourceOutput){
		super.init()
		self.output = output
	}


	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		guard let output = output else { return 0}
		return output.numberOfRows()
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		guard let output = output else { return UICollectionViewCell() }
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
													  for: indexPath) as! FilterCollectionViewCell
		cell.isUserInteractionEnabled = true
		let filterIcon = output.getFilterIcon(indexPath: indexPath)
		cell.imageView.image = filterIcon.image
		cell.label.text = filterIcon.description
		return cell
	}


}
