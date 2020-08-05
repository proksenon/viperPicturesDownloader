//
//  CustomTableViewDelegate.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 04.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomTableViewDelegate: NSObject, UITableViewDelegate {

	var tableView: CustomTableView!
	var presenter: MainPresenterProtocol!

	init(tableView: CustomTableView, presenter: MainPresenterProtocol){
		super.init()
		self.tableView = tableView
		self.tableView.delegate = self
		self.presenter = presenter
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.didSelect(indexPath: indexPath)
	}
}
