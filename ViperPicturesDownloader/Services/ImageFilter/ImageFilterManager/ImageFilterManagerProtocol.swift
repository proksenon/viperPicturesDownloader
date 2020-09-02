//
//  ImageFilterProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 18.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

protocol ImageFilterManagerProtocol {
	/// Количество фильтров
	var countFilters: Int! { get }
	///  Применяет фильтр к картинке
	func apllyFilter(image: UIImage?, index: Int, customParametrs: CustomParameters?, completion: @escaping (UIImage?)-> Void)
	///  Получает стандартные параметры фильтра
	func getParametrs(index: Int)-> [ParametersForSlider]?
	///  Получает иконки фильтров
	func getFiltersIcon(index: Int)-> Image?
}
