//
//  CustomTableViewDelegate.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 04.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomTableViewDelegate: NSObject, UITableViewDelegate {
	/// Кастомная таблица
	var tableView: UITableView!
	var output: TableViewDelegateOutput!

	init(tableView: UITableView, output: TableViewDelegateOutput){
		super.init()
		self.tableView = tableView
		self.tableView.delegate = self
		self.output = output
	}
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		output.didSelect(indexPath: indexPath)
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UIScreen.main.bounds.size.height/3
	}

	func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

		let deleateAction = UITableViewRowAction(style: .default, title: "Удалить") { [weak output] (_, indexPath) in
		output?.didDeleteImage(indexPath: indexPath)
		tableView.deleteRows(at: [indexPath], with: .automatic)
	}
	//deleateAction.backgroundColor = .red
		return [deleateAction]
}


}
