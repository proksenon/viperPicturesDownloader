//
//  CollectionDelegateOutput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol CollectionViewDelegateOutput: class {
	///  Выбрана ячейка, переходит на ImageViewController, отправляя туда картинку
	func didSelect(indexPath: IndexPath)
}
