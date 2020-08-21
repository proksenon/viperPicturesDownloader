//
//  AddImageAlert.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 21.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class AddImageAlert: UIAlertController {

	var output:

	init(){
		super.init(nibName: nil, bundle: nil)
		super.init(title: "Введите ссылку на картинку", message: nil, preferredStyle: .alert)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

	func setupAlert() {
		addTextField { (textField) in
			textField.keyboardType = .alphabet
			textField.placeholder = "url"
		}
		let alertAdd = UIAlertAction(title: "Добавить ссылку", style: .default) { [weak self, weak output] (action) in
			if let textfield = alertVC?.textFields?.first {
				output?.didAddUrl(urlString: textfield.text)
				textfield.text = ""
			}
		}
		let alertNo = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
		addAction(alertAdd)
		addAction(alertNo)
	}

//	func presentAlert() {
//		self.present(alertVC, animated: true)
//	}
}
