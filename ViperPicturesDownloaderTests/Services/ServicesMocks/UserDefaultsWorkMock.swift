//
//  UserDefaultsWorkMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
@testable import ViperPicturesDownloader

class UserDefaultsWorkMock: UserDefaultsWorkProtocol {
	var remove: Bool = false
	var setObjectForKey: Bool = false
	var getObjectForKey: Bool = false
	var setObjectWithDecoderForKey: Bool = false
	var getObjectWithDecoderForKey: Bool = false

	func setObject(for key: String, object: Any?) {
		setObjectForKey = true
	}

	func getObject(for key: String) -> Any? {
		getObjectForKey = true
		return nil
	}

	func setObjectWithDecoder<T>(for key: String, object: T) where T : Encodable {
		setObjectWithDecoderForKey = true
	}

	func getObjectWithDecoder<T>(for key: String) -> T? where T : Decodable {
		getObjectWithDecoderForKey = true
		return nil
	}

	func removeObjects(urls: [String]) {
		remove = true
	}
}
