//
//  NewImageFilterManager.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 01.09.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

protocol ImageFilterManagerProtocol {
	func applyFilter(image: UIImage?, parameters: FilterSettings?)-> UIImage?
}

class ImageFilterManager: ImageFilterManagerProtocol {
	let context = CIContext(options: nil)

	func applyFilter(image: UIImage?, parameters: FilterSettings?)-> UIImage? {
		guard let inputImage = image else { return nil }
		guard let settings = parameters, let parameters = settings.parameters else {return image}


		if let currentFilter = CIFilter(name: settings.name) {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			for (parameter) in parameters {
				currentFilter.setValue(parameter.value, forKey: parameter.key)
			}
			//0.3

			return inputToOutputImage(currentFilter: currentFilter, imageOrientetion: inputImage.imageOrientation)
		}
		return nil
	}

	private func inputToOutputImage(currentFilter: CIFilter, imageOrientetion: UIImage.Orientation )-> UIImage? {
		if let output = currentFilter.outputImage {
			if let cgimg = context.createCGImage(output, from: output.extent) {
				let processedImage = UIImage(cgImage: cgimg, scale: 1.0, orientation: imageOrientetion)
				return processedImage
			}
		}
		return nil
	}
}
