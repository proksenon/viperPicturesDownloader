//
//  ImageFilterProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 18.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

protocol ImageFilterManagerProtocol {
	var countFilters: Int! { get }
	func apllyFilter(image: UIImage?, indexPath: IndexPath, customParametrs: CustomParametrs?, completion: @escaping (UIImage?)-> Void)
	func getParametrs(indexPath: IndexPath)-> [ParametrInfo]?
}
