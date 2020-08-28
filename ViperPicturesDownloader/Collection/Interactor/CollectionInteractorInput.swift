//
//  CollectionInteractorInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol CollectionInteractorInput: class {
	///  Получает картинку
	func getImage(indexPath: IndexPath, size: ImageSize, completion: @escaping (Image)->Void)
	///  Возвращает количество ячеек
	func numberOfRows() -> Int
	///  Устанавливает ссылки на картинки
	func setImageUrls(with urls: ImageUrls)
}
