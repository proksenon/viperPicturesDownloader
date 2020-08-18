//
//  ImageInteractorInput.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 11.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

protocol ImageInteractorInput: class {
	var image: Image! { get set }
	func didSelect(indexPath: IndexPath)->Image
	func originImageSet(image: Image)
	func originImageGet()-> Image
	func filterToImage(indexPath: IndexPath)->Image
	func numberOfRows()-> Int
	func getFilterIcon(indexPath: IndexPath)->Image
}
