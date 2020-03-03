//
//  BoundTextField.swift
//  Bindings
//
//  Created by Ruben Sissing on 03/03/2020.
//  Copyright © 2020 Ruben Sissing. All rights reserved.
//

import UIKit

class BoundTextField: UITextField {
	var changedClosure: (() -> ())?

	@objc
	private func valueChanged() {
		self.changedClosure?()
	}

	func bind(to observable: Observable<String>) {
		self.addTarget(self, action: #selector(self.valueChanged), for: .editingChanged)

		self.changedClosure = { [weak self] in
			observable.bindingChanged(to: self?.text ?? "")
		}

		observable.valueChanged = { [weak self] newValue in
			self?.text = newValue
		}
	}
}
