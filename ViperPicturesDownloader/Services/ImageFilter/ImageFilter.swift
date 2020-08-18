//
//  ImageFilter.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class ImageFilter {

	func sepiaToneFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}
		let context = CIContext(options: nil)

		if let currentFilter = CIFilter(name: "CISepiaTone") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(0.3, forKey: kCIInputIntensityKey)

			if let output = currentFilter.outputImage {
				if let cgimg = context.createCGImage(output, from: output.extent) {
					let processedImage = UIImage(cgImage: cgimg)
					return processedImage
					// do something interesting with the processed image
				}
			}
		}
		return nil
	}

	func gaussianBlurFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}
		let context = CIContext(options: nil)

		if let currentFilter = CIFilter(name: "CIGaussianBlur") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue((5.0), forKey: kCIInputRadiusKey)

			if let output = currentFilter.outputImage {
				if let cgimg = context.createCGImage(output, from: output.extent) {
					let processedImage = UIImage(cgImage: cgimg)
					return processedImage
					// do something interesting with the processed image
				}
			}
		}
		return nil
	}

	func colorControlsFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}
		let context = CIContext(options: nil)

		if let currentFilter = CIFilter(name: "CIColorControls") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(0, forKey: kCIInputBrightnessKey)//0-1
			currentFilter.setValue(5, forKey: kCIInputSaturationKey)
			currentFilter.setValue(1, forKey: kCIInputContrastKey)

			if let output = currentFilter.outputImage {
				if let cgimg = context.createCGImage(output, from: output.extent) {
					let processedImage = UIImage(cgImage: cgimg)
					return processedImage
					// do something interesting with the processed image
				}
			}
		}
		return nil
	}

	func noirFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}
		let context = CIContext(options: nil)

		if let currentFilter = CIFilter(name: "CIPhotoEffectNoir") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)

			if let output = currentFilter.outputImage {
				if let cgimg = context.createCGImage(output, from: output.extent) {
					let processedImage = UIImage(cgImage: cgimg)
					return processedImage
					// do something interesting with the processed image
				}
			}
		}
		return nil
	}

	func edgesFilter(image: UIImage?)-> UIImage? {
		guard let inputImage = image else {return nil}
		let context = CIContext(options: nil)

		if let currentFilter = CIFilter(name: "CIEdges") {
			let beginImage = CIImage(image: inputImage)
			currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
			currentFilter.setValue(20, forKey: kCIInputIntensityKey)

			if let output = currentFilter.outputImage {
				if let cgimg = context.createCGImage(output, from: output.extent) {
					let processedImage = UIImage(cgImage: cgimg)
					return processedImage
					// do something interesting with the processed image
				}
			}
		}
		return nil
	}
	func withoutFilter(image: UIImage?)-> UIImage? {
		return image
	}
}
