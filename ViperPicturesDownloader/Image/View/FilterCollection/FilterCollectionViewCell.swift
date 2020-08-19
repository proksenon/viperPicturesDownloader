//
//  FilterCollectionViewCell.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 17.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
	var imageView = UIImageView()
	var label = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		backgroundColor = .clear
		setImageView()
		setLabel()
		constraintImageView()
		constraintLabel()

	}
	private func setLabel() {
		contentView.addSubview(label)
		label.textAlignment = .center
		label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
		label.textColor = .white
	}
	private func setImageView() {
		contentView.addSubview(imageView)
		imageView.backgroundColor = .clear
	}
	private func constraintImageView() {
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
		imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
		imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
	}
	private func constraintLabel() {
		label.translatesAutoresizingMaskIntoConstraints = false
		label.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
		label.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
		label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
		label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
