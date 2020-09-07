//
//  MainInteractorInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol MainInteractorInput: class {
	///  Получает картинку
	func getImage(imageUrl: String, size: ImageSize, completion: @escaping (ImageModel)->Void)
	///  Требуемое колличество ячеек
//	func numberOfRows() -> Int?
	///  Очищает хранилище, удаляя файлы, которые лежат больше 2 дней
	func freeStorage(befora date: Date?)
	///  Полностью очищает хранилище
	func freeALL(imageUrls: ImageUrls)
	///  Загружает ссылки картинок из UserDefaults или стандартые ссылки
	func setImageUrls()-> ImageUrls?
	///  Сохраняет текущие ссылки на картинки
	func saveImageUrls(imageUrls: ImageUrls?)
	///  Удаляет картинку
	func deleteImage(urlDelete: String)
	///  Обрабатывает картинку с камеры или библиотеки и сохраняет
	func setImage(imageModel: ImageWithUrl)-> String?
}
