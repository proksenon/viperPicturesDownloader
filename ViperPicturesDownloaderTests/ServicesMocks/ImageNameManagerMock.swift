//
//  ImageNameManagerMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
@testable import ViperPicturesDownloader

class ImageNameManagerMock: ImageNameManagerProtocol {

	func getNameFileImage(url: String, size: CGSize?) -> String {
		return "defaultImage"
	}
}
