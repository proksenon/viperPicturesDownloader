//
//  EncryptionManager.swift
//  PicturesDownloader
//
//  Created by 18579132 on 30.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation

final class EncryptionManager: EncryptionManagerProtocol {
	let keyForEncrypte = KeyForEncrypte()
	let encryptionWork = EncryptionWork()
	/// Расшифровывает данные
	func decryptionData(data: Data?)-> Data?{
		guard let data = data, let key = keyForEncrypte.getKey() else { return nil}
			do {
				let decryptData = try encryptionWork.decryptMessage(encryptedMessage: data, encryptionKey: key)
				return decryptData
			} catch let error {
				print(error)
				return nil
			}
		}
	/// Шифрует данные
	func encryptionData(data: Data?)-> Data?{
		guard let data = data, let key = keyForEncrypte.getKey() else { return nil}
		do {
			let encryptData = try encryptionWork.encryptMessage(message: data, encryptionKey: key)
			return encryptData
		} catch let error {
			print(error)
			return nil
		}
	}

}
