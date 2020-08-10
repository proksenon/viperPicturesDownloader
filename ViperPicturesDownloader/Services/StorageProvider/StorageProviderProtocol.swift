//
//  StorageProviderProtocol.swift
//  PicturesDownloader
//
//  Created by 18579132 on 23.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol StorageProviderProtocol {
	func freeStorage(befora date: Date?)
	func freeALL(urls: [String])
}
