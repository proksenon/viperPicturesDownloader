//
//  TableViewDelegateOutput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 10.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol TableViewDelegateOutput: class {
	//Выбрана ячейка, переходит на ImageViewController, отправляя туда картинку
	func didSelect(indexPath: IndexPath)
	//Удаляет картинку из приложения(с таблицы, с кеша, ссылку на картиинку)
	func didDeleteImage(indexPath: IndexPath)
}
