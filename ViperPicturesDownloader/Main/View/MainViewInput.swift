//
//  MainViewInputProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol MainViewInput: class {
	///  Устанавливает View background
	func setViewBackgroud()
	///  Устанавиливает таблицу
	func setTableView()
	///  Устанавливает констрейнты для таблицы
	func setTableConstraints()
	///  Устанавливает кнопку "Collection" перехода на колекшн вью
	func setSegueToCollectionButton()
	///  Настраивает NavigationBar
	func setUpNavigationBar()
	///  Меняет цвет StatusBar на светлый
	func setStatusBarStyleLight()
	///  Устанавливает Alert
	func setupAlert()
	///  Показывает Alert
	func presentAlert()
	///  Устанавливает кнопку "+"
	func setAddUrlButton()
	///  Обновляет таблицу
	func reloadTable()
	///  Опускается в низ таблицы
	func scrollTableTo(indexPath: IndexPath)
}
