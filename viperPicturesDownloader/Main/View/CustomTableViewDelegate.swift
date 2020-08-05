//
//  CustomTableViewDelegate.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 04.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class CustomTableViewDelegate: NSObject, UITableViewDelegate {

	var tableView: CustomTableView!

	init(tableView: CustomTableView){
		super.init()
		self.tableView = tableView
		self.tableView.delegate = self
	}
}
