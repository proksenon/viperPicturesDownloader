//
//  MainViewOutputProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol MainViewOutput: class {
	///  Конфигурирует вью
	func configureView()
	///  Переходит на колекциювью CollectionViewController
	func pushCollection()
	///  Была нажата кнопка добавить ссылку на картинку
	func didAddUrl(urlString: String?)
	///  Показывает Alert
	func presentAlert()
	///  Обрабатывает картинку с камеры или с библиотеки
	func imageFromLibrary(imageModel: ImageWithUrl)
}
