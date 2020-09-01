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
	func getImage(index: Int, size: ImageSize, completion: @escaping (Image)->Void)
	///  Требуемое колличество ячеек
	func numberOfRows() -> Int?
	///  Очищает хранилище, удаляя файлы, которые лежат больше 2 дней
	func freeStorage(befora date: Date?)
	///  Полностью очищает хранилище
	func freeALL()
	///  Добавляет ссылку на картинку
	func didAddUrl(urlString: String?)
	///  Загружает ссылки картинок из UserDefaults или стандартые ссылки
	func setImageUrls()
	///  Сохраняет текущие ссылки на картинки
	func saveImageUrls()
	///  Удаляет картинку
	func deleteImage(index: Int)
	///  Обрабатывает картинку с камеры или библиотеки и сохраняет
	func setImage(imageModel: Image)
	///  Возвращает текушие ссылки на картинки
	func getImageUrls() -> ImageUrls?
}
