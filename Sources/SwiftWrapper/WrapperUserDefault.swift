//
//  WrapperUserDefault.swift
//  PropertyWrapper
//
//  Created by Teng Wang 王腾 on 2020/6/17.
//  Copyright © 2020 Teng Wang 王腾. All rights reserved.
//

import Foundation

@propertyWrapper
public struct WrapperUserDefault<T> {

	/// 存储的key
	public let key: String

	/// 存储的值
	public let value: T!

	public var wrappedValue: T! {
		set {
			guard newValue != nil else {
				UserDefaults.standard.removeObject(forKey: key)
				return
			}
			UserDefaults.standard.set(newValue, forKey: key)
		}
		get {
			UserDefaults.standard.object(forKey: key) as? T
		}
	}

	public init(_ key: String, value: T! = nil) {
		self.key = key
		self.value = value
	}
}
