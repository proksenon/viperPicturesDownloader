//
//  NetworkServiceProtocol.swift
//  PicturesDownloader
//
//  Created by 18579132 on 22.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
	/// Получает данные
	func getData(url: URL, completion: @escaping (Data?) -> ())
}

