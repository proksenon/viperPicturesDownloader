//
//  CollectionViewController.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 05.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit
// View экрана с колекцией
final class CollectionViewController: UIViewController {

	var output: CollectionViewOutput?
	var moduleInput: CollectionModuleInput?
	var collectionView: UICollectionView?
	private let transition = PopAnimator()

	override func viewDidLoad() {
		super.viewDidLoad()
		guard let output = output else { return }
		output.configureView()
	}

}
// MARK: - CollectionViewInput
extension CollectionViewController: CollectionViewInput {

	func setCollection() {
		guard let collectionView = collectionView else { return }

		view.addSubview(collectionView)
	}

	func setCollectionConstraint() {
		guard let collectionView = collectionView else { return }
		
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
			collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
			collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0),
			collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0)
		])
	}
}
// MARK: - UINavigationControllerDelegate
extension CollectionViewController: UINavigationControllerDelegate {

	func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		guard let collectionView = collectionView else { return nil }
		guard
			let selectedIndexPathItem = collectionView.indexPathsForSelectedItems?.first,
			let selectedItem = collectionView.cellForItem(at: selectedIndexPathItem) as? CustomCollectionViewCell,
			let selectedCellSuperview = selectedItem.superview
		  else {
			return nil
		}
		transition.originFrame = selectedCellSuperview.convert(selectedItem.frame, to: collectionView.superview)

        switch operation {
        case .push:
			transition.presenting = true
            return transition
        default:
			transition.presenting = false
            return transition
        }
    }
}
