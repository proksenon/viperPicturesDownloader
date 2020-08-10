//
//  CustomCollectionViewDataSource.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomCollectionViewDataSource: NSObject, UICollectionViewDataSource {

	var collectionView: CustomCollectionView!
	var presenter: CollectionPresenterProtocol!

	init(collectionView: CustomCollectionView, presenter: CollectionPresenterProtocol){
		super.init()
		self.collectionView = collectionView
		self.collectionView.dataSource = self
		self.presenter = presenter
	}


	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return presenter.numberOfRows()
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
													  for: indexPath) as! CustomCollectionViewCell
		let size = CGSize(width: cell.contentView.frame.size.width,
						  height: cell.contentView.frame.size.width)
		presenter.setUpActivity(viewModel: ViewForActivity(view: cell.contentView))
		presenter.startActivity()
		presenter.getImage(indexPath: indexPath, size: ImageSize(size: size)) { (image) in
			cell.imageView.image = image.image
			cell.imageView.contentMode = .scaleAspectFit
			self.presenter.stopActivity()
		}
		return cell
	}


}
