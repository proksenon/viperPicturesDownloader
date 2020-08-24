//
//  CustomTableViewDataSource.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 03.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomTableViewDataSource:NSObject, UITableViewDataSource {

	var tableView: UITableView!
	var output: TableViewDataSourceOutPut!
	
	init(tableView: UITableView, output: TableViewDataSourceOutPut){
		super.init()
		self.tableView = tableView
		self.tableView.dataSource = self
		self.output = output
	}
	/// Количество ячеек
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return output.numberOfRows()
	}
	/// Работа с ячейкой
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
		/// Размер изображения в ячейке
		let size = CGSize(width: cell.contentView.frame.size.width,
						  height: cell.contentView.frame.size.width)
		output.getImage(indexPath: indexPath, size: ImageSize(size: size)) { (image) in
			cell.configureCell(image: image.image)
			cell.stopActivity()
		}
		return cell
	}

}
