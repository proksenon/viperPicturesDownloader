//
//  UserDefaultsWork.swift
//  PicturesDownloader
//
//  Created by 18579132 on 27.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
//Данные картинок хранятся в виде [url : [size : namefile]]

final class UserDefaultsWork: UserDefaultsWorkProtocol {
	private let defaults: UserDefaults

	init(defaults: UserDefaults = UserDefaults.standard) {
		self.defaults = defaults
	}

	func removeObjects(urls: [String]) {
		for url in urls {
			defaults.removeObject(forKey: url)
			defaults.synchronize()
		}
	}

	func setObject(for key: String, object: Any?) {
		defaults.set(object, forKey: key)
		defaults.synchronize()
	}

	func getObject(for key: String)->Any? {
		let object = defaults.object(forKey: key)
		return object
	}
	func setObjectWithDecoder<T: Encodable>(for key: String, object: T) {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(object) {
			defaults.set(encoded, forKey: key)
			defaults.synchronize()
		}
	}

	func getObjectWithDecoder<T: Decodable>(for key: String)-> T? {
		let decoder = JSONDecoder()
		if let imageUrlsEncoded = defaults.object(forKey: key) as? Data {
			if let imageUrlsDecoded = try? decoder.decode(T.self, from: imageUrlsEncoded) {
				return imageUrlsDecoded
			}
		}
		return nil
	}
	
}
