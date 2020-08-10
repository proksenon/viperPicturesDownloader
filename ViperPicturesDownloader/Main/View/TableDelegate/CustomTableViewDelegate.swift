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
	var presenter: TableViewDelegateOutput!

	init(tableView: CustomTableView, presenter: TableViewDelegateOutput){
		super.init()
		self.tableView = tableView
		self.tableView.delegate = self
		self.presenter = presenter
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		presenter.didSelect(indexPath: indexPath)
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UIScreen.main.bounds.size.height/3
	}
	
}
