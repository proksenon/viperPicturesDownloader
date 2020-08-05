//
//  FullImageView.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class FullImageView: UIView {

	var imageView: UIImageView = UIImageView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		self.addSubview(imageView)
		setupImageViewConstraints()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func setupImageViewConstraints() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
	}

}
