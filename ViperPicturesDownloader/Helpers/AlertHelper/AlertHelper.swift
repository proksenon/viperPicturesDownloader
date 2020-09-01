//
//  AlertHelper.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 21.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class AlertHelper: AlertHelperProtocol {

	var alertVC: UIAlertController?

	func setupAlert(alertVC: UIAlertController?) {
		self.alertVC = alertVC
	}

	func alertTextFieldSet() {
		alertVC?.addTextField { (textField) in
			textField.keyboardType = .alphabet
			textField.placeholder = "url"
		}
	}

	func alertAddButtonSet(completion: @escaping (String?)-> Void) {
		let alertAdd = UIAlertAction(title: "Добавить ссылку", style: .default) { [weak alertVC] (action) in
			if let textfield = alertVC?.textFields?.first {
				completion(textfield.text)
				textfield.text = ""
			}
		}
		alertVC?.addAction(alertAdd)
	}

	func alertCancleButtonSet() {
		let alertCancle = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
		alertVC?.addAction(alertCancle)
	}

}
