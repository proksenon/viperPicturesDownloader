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
	var networkService: NetworkServiceMock!
	var fileProvider: FileProviderMock!
	var encryptionManager: EncryptionManagerProtocol!
	var imageNameManager: ImageNameManagerProtocol!
	var imageResizer: ImageResizerMock!
	var userDefaultsWork: UserDefaultsWorkMock!

	let index = 2
	let imageSize = ImageSize(size: nil)
	let image = UIImage(named: "defaultImage")

    override func setUp() {
		output = MainInteractorOutputSpy()
		networkService = NetworkServiceMock()
		fileProvider = FileProviderMock()
		encryptionManager = EncryptionManagerMock()
		imageNameManager = ImageNameManagerMock()
		imageResizer = ImageResizerMock()
		userDefaultsWork = UserDefaultsWorkMock()
		interactor = MainInteractor(presenter: output, imageNameManager: imageNameManager, fileProvider: fileProvider, encryptionManager: encryptionManager, networkService: networkService, imageResizer: imageResizer, userDefaultsWork: userDefaultsWork)
		interactor.setImageUrls()
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

	func testGetImageNetworkService() {

		let defoultImage: UIImage? = UIImage(named: "defaultImage")
		let data = defoultImage?.pngData()

		fileProvider.checkDirectory = false
		networkService.result = data
		fileProvider.result = data
		interactor.getImage(index: index, size: imageSize) { (image) in
			XCTAssertNotNil(image.image)
			XCTAssertTrue(self.fileProvider.wasWritten, "file didnt written")
		}
	}

	func testGetImageFromCacheWithSize() {

		fileProvider.checkDirectory = true

		interactor.getImage(index: index, size: imageSize) { (image) in
			XCTAssertNotNil(image.image)
			XCTAssertFalse(self.fileProvider.wasWritten, "file didnt written")
		}
	}

	func testGetImageFromCacheWithSuccessResize() {

		fileProvider.checkDirectory = true
		fileProvider.changeCheckDirectory = true
		interactor.getImage(index: index, size: imageSize) { (image) in
			XCTAssertNotNil(image.image)
		}
	}

	func testGetImageFromCacheWithFailureResize() {

		fileProvider.checkDirectory = true
		fileProvider.changeCheckDirectory = true
		imageResizer.resize = false
		interactor.getImage(index: index, size: imageSize) { (image) in
			XCTAssertNotNil(image.image)
		}
	}

	func testDeleteImage() {
		let imageSize = ["size": "nameFile"]
//		let count = interactor.imageUrls.urls.count

		userDefaultsWork.object = imageSize
		interactor.deleteImage(urlDelete: index)

		XCTAssertTrue(fileProvider.didRemoveFile, "File didnt remove")
		XCTAssertTrue(userDefaultsWork.remove, "Url didnt delete from userDefaults")
//		XCTAssert(count - 1 == interactor.imageUrls.urls.count, "Urls didnt delete from array")
		XCTAssertTrue(userDefaultsWork.setObjectWithDecoderForKey, "не сохранен новый список ссылок")
	}

	func testDidAddUrlWithString() {
//		let count = interactor.imageUrls.urls.count

		interactor.didAddUrl(urlString: "url")

//		XCTAssert(count + 1 == interactor.imageUrls.urls.count, "Urls didnt delete from array")
		XCTAssertTrue(userDefaultsWork.setObjectWithDecoderForKey, "не сохранен новый список ссылок")
	}

	func testDidAddUrlWithNil() {
//		let count = interactor.imageUrls.urls.count

		interactor.didAddUrl(urlString: nil)

//		XCTAssert(count == interactor.imageUrls.urls.count, "Urls did add from array")
		XCTAssertFalse(userDefaultsWork.setObjectWithDecoderForKey, "Cохранен новый список ссылок")
	}

	func testSetImageFromCamera() {
//		let count = interactor.imageUrls.urls.count
		let imageModel = Image(image: image, urlString: nil)

		fileProvider.checkDirectory = false
		interactor.setImage(imageModel: imageModel)

//		XCTAssert(count + 1 == interactor.imageUrls.urls.count, "Urls didnt delete from array")
		XCTAssertTrue(userDefaultsWork.setObjectWithDecoderForKey, "не сохранен новый список ссылок")
		XCTAssertTrue(self.fileProvider.wasWritten, "file didnt written")
		XCTAssertTrue(fileProvider.didRemoveFileWithType, "file png and jpeg didnt delete")
	}

	func testSetImageFromLibrary() {
//		let count = interactor.imageUrls.urls.count
		let imageModel = Image(image: image, urlString: "url")

		fileProvider.checkDirectory = false
		interactor.setImage(imageModel: imageModel)

//		XCTAssert(count + 1 == interactor.imageUrls.urls.count, "Urls didnt delete from array")
		XCTAssertTrue(userDefaultsWork.setObjectWithDecoderForKey, "не сохранен новый список ссылок")
		XCTAssertTrue(self.fileProvider.wasWritten, "file didnt written")
		XCTAssertTrue(fileProvider.didRemoveFileWithType, "file png and jpeg didnt delete")
	}

	func testFreeStorage() {
		interactor.freeStorage()

		XCTAssertTrue(fileProvider.wasRemovedAll, "Didnt remove all files")
	}

	func testFreeAll() {
		interactor.freeALL()

		XCTAssertTrue(fileProvider.wasRemovedAll, "Didnt remove all files")
		XCTAssertTrue(userDefaultsWork.remove, "Didnt remove all urls from UserDefaults")
	}
}
