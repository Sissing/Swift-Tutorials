//
//  ViewController.swift
//  Bindings
//
//  Created by Ruben Sissing on 03/03/2020.
//  Copyright © 2020 Ruben Sissing. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet private var userNameTextField: BoundTextField!

	private var user = User(name: Observable("Ruben Sissing"))

	override func viewDidLoad() {
		super.viewDidLoad()

		self.userNameTextField.bind(to: self.user.name)

		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			self.user.name.value = "Bilbo Baggins"
		}
	}
}
