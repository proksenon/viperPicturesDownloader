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
	func filterToImage(index: Int, customParametrs: CustomParameters?, completion: @escaping (Image)->Void)
	///  Устанавливает оригинальную картинку
	func originImageSet(image: Image)
	///  Сохраняет картинку в библиотеку
	func saveImageToLibrary()
	///  Возвращает оригинальную картинку
	func originImageGet()-> Image
	///  Количество фильтров
	func numberOfRows()-> Int
	///  Возвращает иконки фильтров
	func getFilterIcon(index: Int)->Image
	///  Возвращает стандартные параметры фильтра
	func getParamsAt(index: Int)->[DefaultParameters]?
}
