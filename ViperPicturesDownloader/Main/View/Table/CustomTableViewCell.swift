//
//  CustomTableViewCell.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 03.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {

	let customImageView = UIImageView()
	let activityIndicator = UIActivityIndicatorView()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.frame.size = CGSize(width: UIScreen.main.bounds.size.width,
										height: UIScreen.main.bounds.size.height/3)
//		addSubview(activityIndicator)
		setActivivty()
		addSubview(customImageView)
		/// констрейнты картинки во всю ячейку
		setImageViewConsstraints()
//		activityIndicator.style = .large
//		activityIndicator.center = contentView.center
//		activityIndicator.startAnimating()
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
	private func setImageViewConsstraints() {
		/// констрейнты картинки во всю ячейку
		customImageView.translatesAutoresizingMaskIntoConstraints = false
		customImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
		customImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
		customImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
		customImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
	}
	 required init?(coder aDecoder: NSCoder) {
	   super.init(coder: aDecoder)
	}

	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	/// метод устанавливает картинку
	func configureCell(image: UIImage?) {
		customImageView.image = image
		customImageView.contentMode = .scaleToFill
	}
}
