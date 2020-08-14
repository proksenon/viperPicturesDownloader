//
//  EncriptionManagerMock.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
@testable import ViperPicturesDownloader

class EncryptionManagerMock: EncryptionManagerProtocol {
	
	func decryptionData(data: Data?) -> Data? {
		return data
	}

	func encryptionData(data: Data?) -> Data? {
		return data
	}


}
