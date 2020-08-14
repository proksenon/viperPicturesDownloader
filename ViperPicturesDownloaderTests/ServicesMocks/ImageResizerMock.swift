//
//  ImageResizerMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
@testable import ViperPicturesDownloader

class ImageResizerMock: ImageResizerProtocol {
	
	var resize: Bool = true

	func imageToSize(nameFile: String, size: CGSize?, data: Data?) -> Data? {
		if resize {
			return data
		}
		return nil
	}
}
