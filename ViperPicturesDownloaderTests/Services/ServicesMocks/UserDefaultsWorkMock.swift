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
	func removeObjects(urls: [String]) {
		remove = true
	}
}
