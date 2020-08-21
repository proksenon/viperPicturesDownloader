//
//  AlertHelperProtocol.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 21.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

protocol AlertHelperProtocol {
	func setupAlert(alertVC: UIAlertController, completion: @escaping (String?)-> Void)
}
