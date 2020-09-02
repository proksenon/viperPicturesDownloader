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
	func newFilterToImage(index: Int, parameters: NewFilterParameters?, completion: @escaping (Image)->Void)
	///  Устанавливает оригинальную картинку
	func originImageSet(image: Image)
	///  Сохраняет картинку в библиотеку
	func saveImageToLibrary()
	///  Возвращает оригинальную картинку
	func originImageGet()-> Image
	///  Количество фильтров
	func newNumberOfRows() -> Int
	///  Возвращает иконки фильтров
	func newGetFilterIcon(index: Int)-> Image
	///  Возвращает значения для слайдеров
	func getParamsForSlider(index: Int) -> [ParametersForSlider]?
	///  Возвращает настройки Фильтра
	func getDefaultParameters(index: Int)-> NewFilterParameters?
}
