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
			_value
		}
		set {
			_value = newValue
			valueChanged?(_value)
		}
	}

	init(_ value: ObservedType) {
		self._value = value
	}

	private func bindingChanged(to newValue: ObservedType) {
		self._value = newValue
		print("Value is now \(newValue)")
	}
}
