//
//  CustomTableViewDataSource.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 03.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomTableViewDataSource:NSObject, UITableViewDataSource {

	weak var output: TableViewDataSourceOutPut?
	
	init(output: TableViewDataSourceOutPut){
		super.init()
		self.output = output
	}
	/// Количество ячеек
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let output = output else { return 0}
		return output.numberOfRows()
	}
	/// Работа с ячейкой
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let output = output else { return UITableViewCell(style: .default, reuseIdentifier: "default") }
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
		/// Размер изображения в ячейке
		let size = CGSize(width: cell.contentView.frame.size.width,
						  height: cell.contentView.frame.size.width)
		cell.currentIndexPath = indexPath
		output.getImage(indexPath: indexPath, size: ImageSize(size: size)) { (image) in
			cell.configureCell(image: image.image, indexPath: indexPath)
			cell.stopActivity()
		}
		return cell
	}

}
