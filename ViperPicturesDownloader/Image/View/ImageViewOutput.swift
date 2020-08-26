//
//  ImageViewOutput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 11.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol ImageViewOutput: class {
	func configureView()
	func popViewController()
	func saveImageToLibrary()
	func filterImage(customParametr: CustomParametrs?)
	func hidenSlidersAndShowCollection() 
}
