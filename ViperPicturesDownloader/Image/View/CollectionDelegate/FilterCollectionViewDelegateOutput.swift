//
//  FilterCollectionViewDelegateOutput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 17.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol FilterCollectionViewDelegateOutput: class {
	///  Передает, что выбран фильтр
//	func didSelect(indexPath: IndexPath)
	func newDidSelect(indexPath: IndexPath)
}
