//
//  ViewController.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol {

	var presenter: MainPresenterProtocol!
	let configurator: MainConfiguratorProtocol = MainConfigurator()
	var tableView: CustomTableView!
	var customTableViewDataSource: CustomTableViewDataSource!
	var customTableViewDelegate: CustomTableViewDelegate!

	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(with: self)
		presenter.configureView()
	}

	func setTableView() {
		tableView = CustomTableView()
		tableView.setTableView(viewController: self)
		customTableViewDataSource = CustomTableViewDataSource(tableView: tableView, presenter: presenter)
		customTableViewDelegate = CustomTableViewDelegate(tableView: tableView)
	}

}
