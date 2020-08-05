//
//  UserDefaultsWork.swift
//  PicturesDownloader
//
//  Created by 18579132 on 27.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

class UserDefaultsWork: UserDefaultsWorkProtocol {
	let defaults = UserDefaults.standard

	func removeObjects(urls: [String]) {
		for url in urls {
			defaults.removeObject(forKey: url)
			defaults.synchronize()
		}
	}
}
