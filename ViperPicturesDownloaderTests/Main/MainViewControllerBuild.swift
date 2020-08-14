//
//  MainViewControllerBuild.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 12.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

class MainViewControllerBuild: XCTestCase {

	func testMainViewControllerBuild() {
		let viewController = MainViewController()
		viewController.viewDidLoad()
		
		XCTAssertNotNil(viewController.configurator,
						"MainViewController is nil after configuration")
		XCTAssertNotNil(viewController.viewOutput,
						"MainViewController is nil after configuration")
		XCTAssertTrue(viewController.viewOutput is MainPresenter,
					  "viewOutput is not MainPresenter")

		let presenter = viewController.viewOutput as? MainPresenter

		XCTAssertNotNil(presenter?.view,
						"view in MainPresenter is nil after configuration")
		XCTAssertTrue(presenter?.interactor is MainInteractor,
					  "interactor is not MainInteractor")
		XCTAssertTrue(presenter?.router is MainRouter,
					  "router is not MainRouter")
		XCTAssertNotNil(viewController.tableView, "table didnt set")
		XCTAssertNotNil(viewController.view.subviews.contains(viewController.tableView), "table didnt add to view")
		XCTAssertNotNil(viewController.segueToCollection, "button for collection didnt configure")
		XCTAssertNotNil(viewController.navigationItem.rightBarButtonItem, "button for collection didnt set")
		XCTAssertNotNil(viewController.customTableViewDelegate, "customTableViewDelegate didnt set")
		XCTAssertNotNil(viewController.customTableViewDataSource, "customTableViewDataSource didnt set")
	}

}
