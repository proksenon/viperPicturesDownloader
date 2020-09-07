//
//  FilterCollectionDataSourceOutput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 17.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol FilterCollectionViewDataSourceOutput: class {
	///  Возвращает количество ячеек
	func numberOfRows()-> Int
	///  Возвращает иконки фильтров
	func getFilterIcon(indexPath: IndexPath)-> ImageWithDesc
}
