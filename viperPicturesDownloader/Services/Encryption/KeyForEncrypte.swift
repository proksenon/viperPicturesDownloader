//
//  KeyForEncrypte.swift
//  PicturesDownloader
//
//  Created by 18579132 on 27.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import Foundation
import KeychainSwift
class KeyForEncrypte {
	let encryption = EncryptionWork()
	let keychain = KeychainSwift()

	func getKey()-> String? {
		if let keyForEncrypte = keychain.get("KeyForEncrypte") {
			print("keyLoad = \(keyForEncrypte)")
			return keyForEncrypte
		} else {
			do {
				let keyForEncrypte = try encryption.generateEncryptionKey(withPassword: "123")
				keychain.set(keyForEncrypte, forKey: "KeyForEncrypte")
				return(keyForEncrypte)
			} catch let error {
				print(error)
			}
		}
		return nil
	}
}

