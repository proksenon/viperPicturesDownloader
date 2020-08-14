//
//  MainInteractorTest.swift
//  ViperPicturesDownloaderTests
//
//  Created by 18579132 on 12.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import XCTest
@testable import ViperPicturesDownloader

class MainInteractorTest: XCTestCase {

	var output: MainInteractorOutput!
	var interactor: MainInteractor!
	var networkService: NetworkServiceProtocol!
	var fileProvider: FileProviderMock!
	var encryptionManager: EncryptionManagerProtocol!
	var imageNameManager: ImageNameManagerProtocol!
	var imageResizer: ImageResizerMock!
	var userDefaultsWork: UserDefaultsWorkProtocol!

	let indexPath = IndexPath(row: 2, section: 1)
	let imageSize = ImageSize(size: nil)

    override func setUp() {
		output = MainInteractorOutputSpy()
		networkService = NetworkServiceMock()
		fileProvider = FileProviderMock()
		encryptionManager = EncryptionManagerMock()
		imageNameManager = ImageNameManagerMock()
		imageResizer = ImageResizerMock()
		userDefaultsWork = UserDefaultsWorkMock()
		interactor = MainInteractor(presenter: output, imageNameManager: imageNameManager, fileProvider: fileProvider, encryptionManager: encryptionManager, networkService: networkService, imageResizer: imageResizer, userDefaultsWork: userDefaultsWork)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
		output = nil
		networkService = nil
		fileProvider = nil
		encryptionManager = nil
		imageNameManager = nil
		imageResizer = nil
		userDefaultsWork = nil
		interactor = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func testNetworkService() {

		var defoultImage: UIImage? = UIImage(named: "defaultImage")

		fileProvider.checkDirectory = false
		interactor.getImage(indexPath: indexPath, size: imageSize) { (image) in
			defoultImage = image.image

			XCTAssertNotNil(image.image)
			XCTAssert(image.image == defoultImage, "wrong Image")
		}
	}

	func testImageFromCacheWithSize() {

		fileProvider.checkDirectory = true

		interactor.getImage(indexPath: indexPath, size: imageSize) { (image) in
			XCTAssertNotNil(image.image)
		}
	}

	func testImageFromCacheWithSuccessResize() {

		fileProvider.checkDirectory = true
		fileProvider.changeCheckDirectory = true
		interactor.getImage(indexPath: indexPath, size: imageSize) { (image) in
			XCTAssertNotNil(image.image)
		}
	}

	func testImageFromCacheWithFailureResize() {

		fileProvider.checkDirectory = true
		fileProvider.changeCheckDirectory = true
		imageResizer.resize = false
		interactor.getImage(indexPath: indexPath, size: imageSize) { (image) in
			XCTAssertNotNil(image.image)
		}
	}

}
