//
//  FiltersImages.swift
//  ViperPicturesDownloader
//
//  Created by 18579132 on 18.08.2020.
//  Copyright © 2020 18579132. All rights reserved.
//

import UIKit

struct FiltersIcons {
	var images: [Image] = [Image(image: UIImage(named: "origin"), description: "Origin"),
						   Image(image: UIImage(named: "sepiaTone"), description: "Sepia"),
						   Image(image: UIImage(named: "colorControls"), description: "ColContr"),
						   Image(image: UIImage(named: "edges"), description: "Edges"),
						   Image(image: UIImage(named: "noir"), description: "Noir"),
						   Image(image: UIImage(named: "gaussinBlur"), description: "Blur")]
}
