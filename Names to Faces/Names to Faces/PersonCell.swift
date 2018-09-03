//
//  PersonCell.swift
//  Names to Faces
//
//  Created by Ruben Sissing on 03/09/2018.
//  Copyright © 2018 Fressh.nl. All rights reserved.
//

import UIKit

class PersonCell: UICollectionViewCell {

	@IBOutlet private(set) var imageView: UIImageView!
	@IBOutlet private(set) var nameLabel: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()

		self.imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
		self.imageView.layer.borderWidth = 2.0
		self.imageView.layer.cornerRadius = 3.0
		self.layer.cornerRadius = 7.0
	}

}
