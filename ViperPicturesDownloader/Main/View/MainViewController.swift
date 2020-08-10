//
//  ViewController.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 31.07.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

	typealias Presenter = MainViewOutputProtocol & TableViewDataSourceOutPutProtocol & TableViewDelegateOutput
	var viewOutput: Presenter!
	let configurator: MainConfiguratorProtocol = MainConfigurator()
	var tableView: CustomTableView!
	var customTableViewDataSource: CustomTableViewDataSource!
	var customTableViewDelegate: CustomTableViewDelegate!
	var button: UIBarButtonItem!

	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(with: self)
		viewOutput.configureView()
	}

}

extension MainViewController: MainViewInputProtocol {
	func setTableView() {
		tableView = CustomTableView()
		view.addSubview(tableView)
		tableView.setTableView(viewController: self)
		customTableViewDataSource = CustomTableViewDataSource(tableView: tableView, presenter: viewOutput)
		customTableViewDelegate = CustomTableViewDelegate(tableView: tableView, presenter: viewOutput)
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
		viewOutput.pushCollection()
	}
}
