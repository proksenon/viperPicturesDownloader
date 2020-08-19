//
//  ImageFilter.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class ImageFilter {

	let context = CIContext(options: nil)

	private func inputToOutputImage(currentFilter: CIFilter)-> UIImage? {
		if let output = currentFilter.outputImage {
			if let cgimg = context.createCGImage(output, from: output.extent) {
				let processedImage = UIImage(cgImage: cgimg)
				return processedImage
				// do something interesting with the processed image
			}
		}
		return nil
	}

	func sepiaToneFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}

		if let currentFilter = CIFilter(name: "CISepiaTone") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(0.3, forKey: kCIInputIntensityKey)

			return inputToOutputImage(currentFilter: currentFilter)
		}
		return nil
	}



	func gaussianBlurFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}

		if let currentFilter = CIFilter(name: "CIGaussianBlur") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue((5.0), forKey: kCIInputRadiusKey)

			return inputToOutputImage(currentFilter: currentFilter)
		}
		return nil
	}

	func colorControlsFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}

		if let currentFilter = CIFilter(name: "CIColorControls") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(0, forKey: kCIInputBrightnessKey)//0-1
			currentFilter.setValue(5, forKey: kCIInputSaturationKey)
			currentFilter.setValue(1, forKey: kCIInputContrastKey)

			return inputToOutputImage(currentFilter: currentFilter)
		}
		return nil
	}

	func noirFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}

		if let currentFilter = CIFilter(name: "CIPhotoEffectNoir") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

			return inputToOutputImage(currentFilter: currentFilter)
		}
		return nil
	}

	func edgesFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}

		if let currentFilter = CIFilter(name: "CIEdges") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(20, forKey: kCIInputIntensityKey)

			return inputToOutputImage(currentFilter: currentFilter)
		}
		return nil
	}

	func pinkCrossPolynomial(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}

		let param = ["inputRedCoefficients" : CIVector(values: [1, 1, 0, 0, 0, 0, 0, 0, 0, 0], count: 10),
					 "inputGreenCoefficients" : CIVector(values: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0], count: 10),
					 "inputBlueCoefficients" : CIVector(values: [1, 0, 1, 0, 0, 0, 0, 0, 0, 0], count: 10)]

		if let currentFilter = CIFilter(name: "CIColorCrossPolynomial", parameters: param) {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			//currentFilter.setValue(20, forKey: "inputRedCoefficients")

			return inputToOutputImage(currentFilter: currentFilter)
		}
		return nil
	}


	func spotColorFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}

		if let currentFilter = CIFilter(name: "CISpotColor") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(CIColor.green, forKey: "inputCenterColor1")
			currentFilter.setValue(CIColor.red, forKey: "inputReplacementColor1")
			currentFilter.setValue(1, forKey: "inputCloseness1")
			currentFilter.setValue(1, forKey: "inputContrast1")

			currentFilter.setValue(CIColor.red, forKey: "inputCenterColor2")
			currentFilter.setValue(CIColor.red, forKey: "inputReplacementColor2")
			currentFilter.setValue(1, forKey: "inputCloseness2")
			currentFilter.setValue(1, forKey: "inputContrast2")

			currentFilter.setValue(CIColor.blue, forKey: "inputCenterColor3")
			currentFilter.setValue(CIColor.blue, forKey: "inputReplacementColor3")
			currentFilter.setValue(1, forKey: "inputCloseness3")
			currentFilter.setValue(1, forKey: "inputContrast3")

			return inputToOutputImage(currentFilter: currentFilter)
		}
		return nil
	}

	func withoutFilter(image: UIImage?)-> UIImage? {
		return image
	}

}
