//
//  CartStorageManager.swift
//  Codeable and UserDefaults
//
//  Created by Louis Tur on 7/5/17.
//  Copyright © 2017 AccessCode. All rights reserved.
//

import Foundation

class CartStorageManager {
	let cart: Cart
	
	init(cart: Cart) {
		self.cart = cart
	}
	
	func saveCart() {
		let defaults = UserDefaults.standard
		do {
			let data = try PropertyListEncoder().encode(self.cart)
			defaults.set(data, forKey: "userCartKey")
		}
		catch {
			print("Error saving cart: \(error)")
		}
	}
	
	class func loadCart() -> Cart {
		let defaults = UserDefaults.standard
		do {
			guard let data = defaults.data(forKey: "userCartKey") else {
				return Cart(items: [])
			}
			
			return try PropertyListDecoder().decode(Cart.self, from: data)
		}
		catch {
			print("Error loading cart: \(error)")
		}
		
		return Cart(items: [])
	}
}
