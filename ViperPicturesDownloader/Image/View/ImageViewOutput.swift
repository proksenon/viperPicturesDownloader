//
//  ImageViewOutput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 11.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol ImageViewOutput: class {
	///  Конфигурирует ImageViewController
	func configureView()
	///  Закрывает ImageViewController
	func popViewController()
	///  Сохраняет картинку в библиотеку
	func saveImageToLibrary()
	///  Вызывает фильтр с пользовательскими параметрами
	func newFilterImage(filterSettings: FilterSettings?)
	///  Скрывает слайдеры и показывает колекшнвью с фильтрами
	func hidenSlidersAndShowCollection()
	///  Изменяет параметры фильтра
	func didChangeFiltersParameters(key: String, value: Any)
}
