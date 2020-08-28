//
//  CustomCollectionViewCell.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomCollectionViewCell: UICollectionViewCell {
	
	var imageView = UIImageView()
	let activityIndicator = UIActivityIndicatorView()

	override init(frame: CGRect) {
		super.init(frame: frame)
		setActivivty()
		contentView.addSubview(imageView)
		setImageView()
		backgroundColor = .clear

	}
	private func setActivivty() {
		addSubview(activityIndicator)
		activityIndicator.style = .large
		activityIndicator.center = contentView.center
		startActivity()
	}
	func stopActivity() {
		activityIndicator.stopAnimating()
	}
	func startActivity() {
		activityIndicator.startAnimating()
	}

	private func setImageView() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
		imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
