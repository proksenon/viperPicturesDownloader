//
//  MainViewOutputProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol MainViewOutput {
	func configureView()
	func pushCollection()
	func didAddUrl(urlString: String?)
	func presentAlert()
	func imageFromLibrary(image: Image)
}
