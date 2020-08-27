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
	var currentIndexPath: IndexPath! {
		didSet {
			customImageView.image = nil
			startActivity()
		}
	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
		contentView.frame.size = CGSize(width: UIScreen.main.bounds.size.width,
										height: UIScreen.main.bounds.size.height/3)
		setActivivty()
		addSubview(customImageView)
		setImageViewConsstraints()
	 }
	///Устанавливает индикатор загрузки
	private func setActivivty() {
		addSubview(activityIndicator)
		activityIndicator.style = .large
		activityIndicator.center = contentView.center
		startActivity()
	}
	///Остонавливает индикатор загрузки
	func stopActivity() {
		activityIndicator.stopAnimating()
	}
	/// Запускает индикатор загрузки
	func startActivity() {
		activityIndicator.startAnimating()
	}
	/// Устанавливает констрейнты для ImageView
	private func setImageViewConsstraints() {
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
	func configureCell(image: UIImage?, indexPath: IndexPath) {
		if currentIndexPath == indexPath {
			customImageView.image = image
			customImageView.contentMode = .scaleToFill
		}
	}
}
