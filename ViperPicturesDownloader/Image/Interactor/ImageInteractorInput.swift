//
//  ImageInteractorInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 11.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

protocol ImageInteractorInput: class {

	func filterToImage(indexPath: IndexPath, customParametrs: CustomParametrs?, completion: @escaping (Image)->Void)
	func originImageSet(image: Image)
	func saveImageToLibrary()
	func originImageGet()-> Image
	func numberOfRows()-> Int
	func getFilterIcon(indexPath: IndexPath)->Image
	func getParamsAt(indexPath: IndexPath)->[ParametrInfo]?
}
