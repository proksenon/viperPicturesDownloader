//
//  UserDefaultsWorkProtocol.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 04.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol UserDefaultsWorkProtocol {
	///  Удаляет в юзер дефолтс данные о картинках
	func removeObjects(urls: [String])
	///  Устанавливает данные в UserDefaults
	func setObject(for key: String, object: Any?)
	///  Получает данные в UserDefaults
	func getObject(for key: String)->Any?
	///  Устанавливает данные в UserDefaults с декодером
	func setObjectWithDecoder<T: Encodable>(for key: String, object: T)
	///  Получает данные в UserDefaults с декодером
	func getObjectWithDecoder<T: Decodable>(for key: String)-> T?
}
