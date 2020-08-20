//
//  UserDefaultsWorkProtocol.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 04.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol UserDefaultsWorkProtocol {
	func removeObjects(urls: [String])
	func setObject(for key: String, object: Any?)
	func getObject(for key: String)->Any?
	func setObjectWithDecoder<T: Encodable>(for key: String, object: T)
	func getObjectWithDecoder<T: Decodable>(for key: String)-> T?
}
