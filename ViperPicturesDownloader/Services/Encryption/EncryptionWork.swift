//
//  EncryptionWork.swift
//  PicturesDownloader
//
//  Created by 18579132 on 27.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
import RNCryptor
import Foundation
final class EncryptionWork {

   func encryptMessage(message: Data, encryptionKey: String) throws -> Data {
		   let cipherData = RNCryptor.encrypt(data: message, withPassword: encryptionKey)
		   return cipherData
	   }

	func decryptMessage(encryptedMessage: Data, encryptionKey: String) throws -> Data {
		   let decryptedData = try RNCryptor.decrypt(data: encryptedMessage, withPassword: encryptionKey)
		   return decryptedData
	   }

	func generateEncryptionKey(withPassword password:String) throws -> String {
		let randomData = RNCryptor.randomData(ofLength: 32)
		let cipherData = RNCryptor.encrypt(data: randomData, withPassword: password)
		return cipherData.base64EncodedString()
	}
}
