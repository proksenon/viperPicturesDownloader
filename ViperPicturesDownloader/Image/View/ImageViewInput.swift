//
//  ImageViewInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 11.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol ImageViewInput: class {
	///  Устанавливает цвет View
	func backgroundColor()
	///  Устанавливает кнопку "Cancel"
	func setCancelButton()
	///  Устанавливает констрейнты кнопки "Cancel"
	func setCancelButtonConstraints()
	///  Скрывает или показывает кнопку "Cancel"
	func isHiddenCancleButton(_ isHidden: Bool)
	///  Устанавливает слайдеры
	func setupSliders()
	///  Устанавливает слайдерам констрейнты
	func setSlidersConstraint()
	///  Устанавливает слайдерам стандартные параметры фиьтра
	func newSetDefaultValueToSlider(sliderNubmer: Int, minValue: Float, maxValue: Float, defaultValue: Float, identifier: String)
	///  Скрывает или показывает (количество: count ) слайдеры
	func isHiddenSliders(count: Int, _ isHidden: Bool)
	///  Устанавливает ImageView
	func setUpImageView()
	///  Конфигурирует ImageView
	func configureImageView()
	///  Устанавливает картинку в ImageView
	func setImage(with image: Image)
	///  Устанавливает CollectionView
	func setUpCollection()
	///  Устанавливает констреунты для CollectionView
	func constraintCollection()
	///  Скрывает или показывает CollectionView
	func ishiddenCollection(_ isHidden: Bool)
	///  Устанавливает кнопку "Save"
	func setUpSaveButton()
}
