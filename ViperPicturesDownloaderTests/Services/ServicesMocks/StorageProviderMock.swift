//
//  StorageProviderMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
@testable import ViperPicturesDownloader

class StorageProviderMock: StorageProviderProtocol {
	var cleanStorage: Bool = false
	var cleanAll: Bool = false

	func freeStorage(befora date: Date?) {
		cleanStorage = true
	}

	func freeALL(urls: [String]) {
		cleanAll = true
	}


}
