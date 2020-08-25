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

	private func inputToOutputImage(currentFilter: CIFilter, imageOrientetion: UIImage.Orientation )-> UIImage? {
		if let output = currentFilter.outputImage {
			if let cgimg = context.createCGImage(output, from: output.extent) {
				let processedImage = UIImage(cgImage: cgimg, scale: 1.0, orientation: imageOrientetion)
				return processedImage
				// do something interesting with the processed image
			}
		}
		return nil
	}

	func sepiaToneFilter(image: UIImage?, customParametrs: CustomParametrs? = nil)-> UIImage? {
		guard let inputImage = image else {return nil}

		var intensity = customParametrs?.parametrs[0]

		if let currentFilter = CIFilter(name: "CISepiaTone") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(intensity, forKey: kCIInputIntensityKey)//0.3

			return inputToOutputImage(currentFilter: currentFilter, imageOrientetion: inputImage.imageOrientation)
		}
		return nil
	}

	func gaussianBlurFilter(image: UIImage?, customParametrs: CustomParametrs? = nil)-> UIImage? {
		guard let inputImage = image else {return nil}

		var radius = customParametrs?.parametrs[0]

		if let currentFilter = CIFilter(name: "CIGaussianBlur") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(radius, forKey: kCIInputRadiusKey)//(2.5)

			return inputToOutputImage(currentFilter: currentFilter, imageOrientetion: inputImage.imageOrientation)
		}
		return nil
	}

	func colorControlsFilter(image: UIImage?, customParametrs: CustomParametrs? = nil)-> UIImage? {
		guard let inputImage = image, let customParametrs = customParametrs else {return nil}

		let brightness = customParametrs.parametrs[0]
		let saturation = customParametrs.parametrs[1]
		let contrast = customParametrs.parametrs[2]
		
		if let currentFilter = CIFilter(name: "CIColorControls") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(brightness, forKey: kCIInputBrightnessKey)//0-1 0
			currentFilter.setValue(saturation, forKey: kCIInputSaturationKey)//5
			currentFilter.setValue(contrast, forKey: kCIInputContrastKey)//1

			return inputToOutputImage(currentFilter: currentFilter, imageOrientetion: inputImage.imageOrientation)
		}
		return nil
	}

	func noirFilter(image: UIImage?, customParametrs: CustomParametrs? = nil)-> UIImage? {
		guard let inputImage = image else {return nil}

		if let currentFilter = CIFilter(name: "CIPhotoEffectNoir") {
			let beginImage = CIImage(image: inputImage)

			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

			return inputToOutputImage(currentFilter: currentFilter, imageOrientetion: inputImage.imageOrientation)
		}
		return nil
	}

	func edgesFilter(image: UIImage?, customParametrs: CustomParametrs? = nil)-> UIImage? {
		guard let inputImage = image else {return nil}

		var intensity = customParametrs?.parametrs[0]

		if let currentFilter = CIFilter(name: "CIEdges") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(intensity, forKey: kCIInputIntensityKey)//20

			return inputToOutputImage(currentFilter: currentFilter, imageOrientetion: inputImage.imageOrientation)
		}
		return nil
	}

	func pinkCrossPolynomial(image: UIImage?, customParametrs: CustomParametrs? = nil)-> UIImage? {
		guard let inputImage = image else {return nil}

		let param = ["inputRedCoefficients" : CIVector(values: [1, 1, 0, 0, 0, 0, 0, 0, 0, 0], count: 10),
					 "inputGreenCoefficients" : CIVector(values: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0], count: 10),
					 "inputBlueCoefficients" : CIVector(values: [1, 0, 1, 0, 0, 0, 0, 0, 0, 0], count: 10)]

		if let currentFilter = CIFilter(name: "CIColorCrossPolynomial", parameters: param) {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			//currentFilter.setValue(20, forKey: "inputRedCoefficients")

			return inputToOutputImage(currentFilter: currentFilter, imageOrientetion: inputImage.imageOrientation)
		}
		return nil
	}


	func spotColorFilter(image: UIImage?, customParametrs: CustomParametrs? = nil)-> UIImage? {
		guard let inputImage = image else {return nil}

		var closenessG = customParametrs?.parametrs[0]
		var closenessR = customParametrs?.parametrs[1]
		var closenessB = customParametrs?.parametrs[2]

		if let currentFilter = CIFilter(name: "CISpotColor") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(CIColor.green, forKey: "inputCenterColor1")
			currentFilter.setValue(CIColor.red, forKey: "inputReplacementColor1")
			currentFilter.setValue(closenessG, forKey: "inputCloseness1")
			currentFilter.setValue(1, forKey: "inputContrast1")

			currentFilter.setValue(CIColor.red, forKey: "inputCenterColor2")
			currentFilter.setValue(CIColor.blue, forKey: "inputReplacementColor2")
			currentFilter.setValue(closenessR, forKey: "inputCloseness2")
			currentFilter.setValue(1, forKey: "inputContrast2")

			currentFilter.setValue(CIColor.blue, forKey: "inputCenterColor3")
			currentFilter.setValue(CIColor.green, forKey: "inputReplacementColor3")
			currentFilter.setValue(closenessB, forKey: "inputCloseness3")
			currentFilter.setValue(1, forKey: "inputContrast3")

			return inputToOutputImage(currentFilter: currentFilter, imageOrientetion: inputImage.imageOrientation)
		}
		return nil
	}

	func withoutFilter(image: UIImage?, customParametrs: CustomParametrs? = nil)-> UIImage? {
		return image
	}

}
