//
//  FreeStorage.swift
//  PicturesDownloader
//
//  Created by 18579132 on 23.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

final class StorageProvider: StorageProviderProtocol {
	let fileProvider: FileProviderProtocol
	let userDefaultsWork: UserDefaultsWorkProtocol

	init(fileProvider: FileProviderProtocol = FileProvider(),
		 userDefaultsWork: UserDefaultsWorkProtocol = UserDefaultsWork()) {
		self.fileProvider = fileProvider
		self.userDefaultsWork = userDefaultsWork
	}
	/// Удаляет все файлы, созданные до даты
	func freeStorage(befora date: Date? = Calendar.current.date(byAdding: .day, value: -2, to: Date())){
		fileProvider.removeAllFiles(before: date)
	}
	/// Удаляет все файлы
	func freeALL(urls: [String]) {
		fileProvider.removeAllFiles(before: nil)
		userDefaultsWork.removeObjects(urls: urls)
	}

}
