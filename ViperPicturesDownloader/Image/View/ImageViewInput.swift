//
//  ImageViewInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 11.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol ImageViewInput: class {
	func setUpImageView()
	func configureImageView()
	func setUpCollection()
	func constraintCollection()
	func setImage(with image: Image)
	func setUpSaveButton()
	func backgroundColor()
	func setupSliders()
	func setSlidersConstraint()
	func ishiddenCollection(_ isHidden: Bool)
	func isHiddenSliders(count: Int, _ isHidden: Bool)
	func setDefaultValueToSlider(sliderNubme: Int, minValue: Float, maxValue: Float, defaultValue: Float)
	func setCancleButton()
	func setCancleButtonConstraints()
	func isHiddenCancleButton(_ isHidden: Bool)
}
