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
//	let viewForActivity = ViewForActivity(view: UIView(frame: .zero))

    override func setUp() {
		view = MainViewInputSpy()
		interactor = MainInteractorInputSpy()
		router = MainRouterInputSpy()
		presenter = MainPresenter(view: view)
		presenter.interactor = interactor
		presenter.router = router
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
		DispatchQueue.global(qos: .background).async {
			XCTAssertTrue(self.interactor.didFreeStorage, "Didnt free Storage")
		}
	}

	func testDidSelect() {
		presenter.didSelect(indexPath: indexPath)

		XCTAssertTrue(router.didPush, "Didnt push after select row")
	}

//	func testSetUpActivity() {
//		presenter.setUpActivity(viewModel: viewForActivity)
//
//		XCTAssertTrue(interactor.setActivity, "Didnt set Activity")
//	}
//
//	func testStartActivity() {
//		presenter.startActivity()
//
//		XCTAssertTrue(interactor.didStartActivity, "Didnt start Activity")
//	}
//
//	func testStopActivity() {
//		presenter.stopActivity()
//
//		XCTAssertTrue(interactor.didStopActivity, "Didnt stop Activity")
//	}

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

}
