//
//  ImageResizerTests.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 14.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

class ImageResizerTests: XCTestCase {
	var imageResizer: ImageResizerProtocol!
	var image: UIImage?
	let nameFile = "image"
    override func setUp() {
		imageResizer = ImageResizer()
		image = UIImage(named: "defaultImage")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
		image = nil
		imageResizer = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testOriginImageResize() {
		let data = imageResizer.imageToSize(size: nil, data: image?.pngData())

		XCTAssertNil(data, "Resizer cant resize original")
	}

	func testResizeImage() {
		let data = imageResizer.imageToSize(size: CGSize(width: 25, height: 25), data: image?.pngData())

		XCTAssertNotNil(data, "Data after resize is nil")
	}

}
