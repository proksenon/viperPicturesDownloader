//
//  CustomTableView.swift
//  viperPicturesDownloader
//
//  Created by 18579132 on 03.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//
import UIKit

final class CustomTableView: UITableView {

	init() {
		super.init(frame: .zero, style: .plain)
		register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
		tableFooterView = UIView()
		separatorStyle = .none
//		insetsContentViewsToSafeArea = false
		contentInsetAdjustmentBehavior = .never
		//tableHeaderView?.isHidden = true
//		automaticallyAdjustsScrollIndicatorInsets = false
//		contentView.frame.size = CGSize(width: UIScreen.main.bounds.size.width,
//		height: UIScreen.main.bounds.size.height/3)

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
