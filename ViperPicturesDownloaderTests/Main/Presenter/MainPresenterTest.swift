//
//  MainPresenterTest.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 13.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

class MainPresenterTest: XCTestCase {
	var view: MainViewInputSpy!
	var interactor: MainInteractorInputSpy!
	var router: MainRouterInputSpy!
	var presenter: MainPresenter!
	let indexPath = IndexPath(item: 2, section: 1)

    override func setUp() {
		view = MainViewInputSpy()
		interactor = MainInteractorInputSpy()
		router = MainRouterInputSpy()
		presenter = MainPresenter(view: view)
		presenter.interactor = interactor
		presenter.router = router
		let urls = ImageUrls()
		interactor.number = urls.urls.count
		interactor.imageUrls = urls
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
		view = nil
		interactor = nil
		router = nil
		presenter = nil

        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testPushCollection() {
		presenter.pushCollection()

		XCTAssertTrue(router.didPushCollection, "didnt jump")
	}

	func testConfigureView() {
		presenter.configureView()

		XCTAssertTrue(view.didSetTable, "table didnt set")
		XCTAssertTrue(view.didSetButton, "Button didnt set")
		XCTAssertTrue(view.didSetViewBackgroud, "Didnt set Background")
		XCTAssertTrue(view.didSetTableConstraints, "Table constaints didnt set")
		XCTAssertTrue(view.didSetStatusBarStyleLight, "Style stroryboard didnt set")
		XCTAssertTrue(view.didSetupAlert, "Akert didnt set")
		XCTAssertTrue(view.didSetAddUrlButton, "AddButton didnt set")
		XCTAssertTrue(view.didSetupNavigationBar, "NavigationBar didnt set")
		DispatchQueue.global(qos: .background).async {
			XCTAssertTrue(self.interactor.didFreeStorage, "Didnt free Storage")
		}
	}

	func testDidSelect() {
		presenter.didSelect(indexPath: indexPath)

		XCTAssertTrue(interactor.didGetImage, "Didnt push after select row")
		XCTAssertTrue(router.didPush, "Didnt push after select row")
	}

	func testPresentAlert() {
		presenter.presentAlert()

		XCTAssertTrue(view.didPresentAlert, "Alert didnt present")
	}

	func testReloadTable() {
		guard let view = presenter.view else {XCTFail(); return}
		view.reloadTable()

		XCTAssertTrue(self.view.didReloadTable, "Table didnt reload")
	}

	func testGetImage() {
		presenter.getImage(indexPath: indexPath, size: ImageSize(size: nil)) { (image) in
			XCTAssertNil(image.image, "Shcould be nil")
		}

		XCTAssertTrue(interactor.didGetImage, "Interactor didnt get response on Image")
	}

	func testNumberOfRows() {

		let number = presenter.numberOfRows()

		XCTAssertTrue(interactor.getNumberOfRows, "Didnt get numberOfROws")
		XCTAssert(number == interactor.number, "Wrong numberOfRows")
	}

	func testDidAddUrl() {
		presenter.didAddUrl(urlString: "sss")

		XCTAssertTrue(interactor.addUrl, "Url didnt add")
		XCTAssertTrue(view.didReloadTable, "Table didnt reload")
		XCTAssertTrue(view.didScrollTableTo, "Table didnt scroll to")
	}

	func testImageFromLibrary() {
		presenter.imageFromLibrary(image: Image(image: nil))

		XCTAssertTrue(interactor.didSetImage, "Urls didnt set")
		XCTAssertTrue(view.didReloadTable, "Table didnt reload")
		XCTAssertTrue(view.didScrollTableTo, "Table didnt scroll to")
	}

	func testDidDeleteImage() {
		presenter.didDeleteImage(indexPath: indexPath)

		XCTAssertTrue(interactor.didDeleteImage, "Image didnt delete")
	}

}
