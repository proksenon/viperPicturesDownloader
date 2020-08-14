//
//  UserDefaultsMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

class UserDefaultsMock: UserDefaults {
	var keys: [String] = []
	var result: Any?
	var setNewName: Bool = false
	var synchron: Bool = false
	var remove: Bool = false

	override func set(_ value: Any?, forKey key: String) {
		keys.append(key)
		setNewName = true
	}

	override func object(forKey defaultName: String) -> Any? {
		if keys.contains(defaultName) {
			return result
		}
		return nil
	}
	
	override func synchronize() -> Bool {
		synchron = true
		return true
	}

	override func removeObject(forKey defaultName: String) {
		remove = true
	}
}
