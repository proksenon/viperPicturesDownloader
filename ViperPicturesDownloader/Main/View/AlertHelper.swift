//
//  AlertHelper.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 21.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class AlertHelper: AlertHelperProtocol {

	func setupAlert(alertVC: UIAlertController, completion: @escaping (String?)-> Void) {
		//alertVC = UIAlertController(title: "Введите ссылку на картинку", message: nil, preferredStyle: .alert)
		alertVC.addTextField { (textField) in
			textField.keyboardType = .alphabet
			textField.placeholder = "url"
		}
		let alertAdd = UIAlertAction(title: "Добавить ссылку", style: .default) { [weak alertVC] (action) in
			if let textfield = alertVC?.textFields?.first {
				completion(textfield.text)
				textfield.text = ""
			}
		}
		let alertNo = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
		alertVC.addAction(alertAdd)
		alertVC.addAction(alertNo)
	}
}
