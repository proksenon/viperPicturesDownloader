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
	func apllyFilter(image: UIImage?, indexPath: IndexPath, customParametrs: CustomParameters?, completion: @escaping (UIImage?)-> Void)
	///  Получает стандартные параметры фильтра
	func getParametrs(indexPath: IndexPath)-> [DefaultParameters]?
	///  Получает иконки фильтров
	func getFiltersIcon(indexPath: IndexPath)-> Image?
}
