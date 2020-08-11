//
//  ActivityIndicator.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 06.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class ActivityIndicator: ActivityIndicatorProtocol {
    let view: UIView
	let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    init(view: UIView) {
        self.view = view
		activityIndicator.style = .large
		activityIndicator.center = view.center
		print(view.center)
    }
	/// Включает ActivityIndicator
	func startActivity() {
		activityIndicator.startAnimating()
		view.addSubview(activityIndicator)
	}
	/// Выключает ActivityIndicator
	func stopActivity() {
		activityIndicator.stopAnimating()
	}

}
