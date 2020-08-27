//
//  EncryptionManagerProtocol.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 04.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

protocol EncryptionManagerProtocol {
	/// Расшифровывает данные
	func decryptionData(data: Data?)-> Data?
	/// Шифрует данные
	func encryptionData(data: Data?)-> Data?
}
