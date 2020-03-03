//
//  Observable.swift
//  Bindings
//
//  Created by Ruben Sissing on 03/03/2020.
//  Copyright © 2020 Ruben Sissing. All rights reserved.
//

import Foundation

class Observable<ObservedType> {
	private var _value: ObservedType?
	var valueChanged: ((ObservedType?) -> ())?
	var value: ObservedType? {
		get {
			self._value
		}
		set {
			self._value = newValue
			self.valueChanged?(self._value)
		}
	}

	init(_ value: ObservedType) {
		self._value = value
	}

	func bindingChanged(to newValue: ObservedType) {
		self._value = newValue
		print("Value is now \(newValue)")
	}
}
