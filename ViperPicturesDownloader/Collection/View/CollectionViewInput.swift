//
//  CollectionViewInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol CollectionViewInput: class {
	///  Устанавливает CollectionVIew
	func setCollection()
	///  Устанавливает констрейнты на CollectionView
	func setCollectionConstraint()
}
