//
//  CustomParameters.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 31.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

///		Модель пользовательских параметров фильтра
struct CustomParameters {
	var parameters: [Float]
}

struct FilterParameters {
	var parameters: [String: Any]
}
struct DefParameter {
	var key: String
	var value: Any
}
