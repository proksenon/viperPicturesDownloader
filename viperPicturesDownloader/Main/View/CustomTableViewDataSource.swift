//
//  CustomTableViewDataSource.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 03.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class CustomTableViewDataSource:NSObject, UITableViewDataSource {

	var tableView: CustomTableView!
	var presenter: MainPresenterProtocol!
	
	init(tableView: CustomTableView, presenter: MainPresenterProtocol){
		super.init()
		self.tableView = tableView
		self.tableView.dataSource = self
		self.presenter = presenter
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return presenter.numberOfRows()
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
		NSLayoutConstraint.activate([cell.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height/3)])
		cell.contentView.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/3)
		presenter.setUpActivity(viewModel: ViewForActivity(view: cell.contentView))
		presenter.startActivity()
		let size = CGSize(width: cell.contentView.frame.size.width, height: cell.contentView.frame.size.width)
		presenter.getImage(indexPath: indexPath, size: ImageSize(size: size)) { (image) in
			cell.configureCell(image: image.image)
			self.presenter.stopActivity()
		}
		return cell
	}

}
