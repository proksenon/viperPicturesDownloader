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
	func filterToImage(imageModel: Image, filterSettings: FilterSettings?, completion: @escaping (Image)->Void)
	///  Сохраняет картинку в библиотеку
	func saveImageToLibrary(imageModel: Image?, filterSettings: FilterSettings?)
}
