//
//  FreeStorage.swift
//  PicturesDownloader
//
//  Created by 18579132 on 23.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

final class StorageProvider: StorageProviderProtocol {
	let fileProvider: FileProviderProtocol = FileProvider()
	let userDefaultsWork = UserDefaultsWork()

	func freeStorage(befora date: Date? = Calendar.current.date(byAdding: .day, value: -2, to: Date())){
		fileProvider.removeAllFiles(before: date)
	}

	func freeALL(urls: [String]) {
		fileProvider.removeAllFiles(before: nil)
		userDefaultsWork.removeObjects(urls: urls)
	}

}
