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
	func filterToImage(imageModel: ImageModel, filterSettings: FilterSettings?, completion: @escaping (ImageModel)->Void)
	///  Сохраняет картинку в библиотеку
	func saveImageToLibrary(imageModel: ImageModel?, filterSettings: FilterSettings?)
}
