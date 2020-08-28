//
//  CollectionViewDataSourceOutput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol CollectionViewDataSourceOutput: class {
	///  Получает картинку
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	///  Колличество ячеек
	func numberOfRows() ->Int
}
