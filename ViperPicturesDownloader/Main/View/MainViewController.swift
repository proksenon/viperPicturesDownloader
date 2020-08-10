//
//  ViewController.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController, MainViewProtocol {

	var presenter: MainPresenterProtocol!
	let configurator: MainConfiguratorProtocol = MainConfigurator()
	var tableView: CustomTableView!
	var customTableViewDataSource: CustomTableViewDataSource!
	var customTableViewDelegate: CustomTableViewDelegate!
	var button: UIBarButtonItem!

	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(with: self)
		presenter.configureView()
	}

	func setTableView() {
		tableView = CustomTableView()
		view.addSubview(tableView)
		tableView.setTableView(viewController: self)
		customTableViewDataSource = CustomTableViewDataSource(tableView: tableView, presenter: presenter)
		customTableViewDelegate = CustomTableViewDelegate(tableView: tableView, presenter: presenter)
	}
	func setButton() {
		button = UIBarButtonItem(title: "Collection",
								 style: UIBarButtonItem.Style.done,
								 target: self,
								 action: #selector(makeCollection(_:))
								)
		navigationItem.rightBarButtonItem = button
	}

	@objc func makeCollection(_ sender: UIBarButtonItem){
		presenter.pushCollection()
	}
}
