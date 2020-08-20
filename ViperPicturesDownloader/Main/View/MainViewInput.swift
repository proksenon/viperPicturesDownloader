//
//  MainViewInputProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol MainViewInput: class {
	func setTableView()
	func setTableConstraints()
	func setButton()
	func setUpNavigationBar()
	func setStatusBarStyleLight()
	func setupAlert()
	func presentAlert()
	func setAddUrlButton()
	func reloadTable()
}
