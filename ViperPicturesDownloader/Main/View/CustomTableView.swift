//
//  CustomTableView.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 03.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//
import UIKit

final class CustomTableView: UITableView {

	func setTableView(viewController: MainViewController) {
		register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
		tableFooterView = UIView()
		reloadData()
		translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: -50),
			bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: 50),
			leftAnchor.constraint(equalTo: viewController.view.leftAnchor, constant: 0),
			rightAnchor.constraint(equalTo: viewController.view.rightAnchor, constant: 0)
		])
	}
}
