//
//  ImageFilterProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 27.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

protocol ImageFilterProtocol: class {
	///  Без фильтра
	func withoutFilter(image: UIImage?, customParametrs: CustomParametrs?)-> UIImage?
	///                                          Фильтры картинок
	func sepiaToneFilter(image: UIImage?, customParametrs: CustomParametrs?)-> UIImage?
	func colorControlsFilter(image: UIImage?, customParametrs: CustomParametrs?)-> UIImage?
	func edgesFilter(image: UIImage?, customParametrs: CustomParametrs?)-> UIImage?
	func noirFilter(image: UIImage?, customParametrs: CustomParametrs?)-> UIImage?
	func gaussianBlurFilter(image: UIImage?, customParametrs: CustomParametrs?)-> UIImage?
	func pinkCrossPolynomial(image: UIImage?, customParametrs: CustomParametrs?)-> UIImage?
	func spotColorFilter(image: UIImage?, customParametrs: CustomParametrs?)-> UIImage?
}
