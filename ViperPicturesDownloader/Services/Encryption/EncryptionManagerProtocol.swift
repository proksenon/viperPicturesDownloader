//
//  EncryptionManagerProtocol.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 04.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol EncryptionManagerProtocol {
	func decryptionData(data: Data?)-> Data?
	func encryptionData(data: Data?)-> Data?
}
