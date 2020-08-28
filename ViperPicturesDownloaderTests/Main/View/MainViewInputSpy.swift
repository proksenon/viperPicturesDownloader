//
//  MainViewInputSpy.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
@testable import ViperPicturesDownloader

class MainViewInputSpy: MainViewInput {

	var didSetTable: Bool = false
	var didSetButton: Bool = false
	var didSetViewBackgroud: Bool = false
	var didSetTableConstraints: Bool = false
	var didSetStatusBarStyleLight: Bool = false
	var didSetupAlert: Bool = false
	var didPresentAlert: Bool = false
	var didSetAddUrlButton: Bool = false
	var didReloadTable: Bool = false
	var didScrollTableTo: Bool = false
	var didSetupNavigationBar: Bool = false


	func setTableView() {
		didSetTable = true
	}

	func setSegueToCollectionButton() {
		didSetButton = true
	}

	func setViewBackgroud() {
		didSetViewBackgroud = true
	}

	func setTableConstraints() {
		didSetTableConstraints = true
	}

	func setStatusBarStyleLight() {
		didSetStatusBarStyleLight = true
	}

	func setupAlert() {
		didSetupAlert = true
	}

	func presentAlert() {
		didPresentAlert = true
	}

	func setAddUrlButton() {
		didSetAddUrlButton = true
	}

	func reloadTable() {
		didReloadTable = true
	}

	func scrollTableTo(indexPath: IndexPath) {
		didScrollTableTo = true
	}

	func setUpNavigationBar() {
		didSetupNavigationBar = true
	}
}
