//
//  ImageInteractorInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 11.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

protocol ImageInteractorInput: class {
	///  Обращается к менеджеру фильтров, и применяет фильтр
	func filterToImage(indexPath: IndexPath, customParametrs: CustomParameters?, completion: @escaping (Image)->Void)
	///  Устанавливает оригинальную картинку
	func originImageSet(image: Image)
	///  Сохраняет картинку в библиотеку
	func saveImageToLibrary()
	///  Возвращает оригинальную картинку
	func originImageGet()-> Image
	///  Количество фильтров
	func numberOfRows()-> Int
	///  Возвращает иконки фильтров
	func getFilterIcon(indexPath: IndexPath)->Image
	///  Возвращает стандартные параметры фильтра
	func getParamsAt(indexPath: IndexPath)->[DefaultParameters]?
}
