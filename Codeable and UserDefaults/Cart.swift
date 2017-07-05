//
//  Cart.swift
//  Codeable and UserDefaults
//
//  Created by Louis Tur on 7/5/17.
//  Copyright © 2017 AccessCode. All rights reserved.
//

import Foundation

class Cart: Codable, Equatable {
	var items: [CartItem] = []
	
	// Advanced
	static func ==(_ lhs: Cart, _ rhs: Cart) -> Bool {
		guard lhs.items.count == rhs.items.count else {
			return false
		}
		
		for (idx, item) in lhs.items.enumerated() {
			if item != rhs.items[idx] {
				return false
			}
		}
		
		return true
	}
	
	init(items: [CartItem]) {
		self.items = items
	}
	
	// adds an items to the .items property
	func addItem(_ item: CartItem) {
		self.items.append(item)
	}
	
	// attempts remove an item, returns true if successful. false otherwise
	func removeItem(_ item: CartItem)  -> Bool {

		guard let index = items.index(where: {
			if $0.sku == item.sku {
				return true
			}
			return false
		}) else {
			return false
		}
		
		// Advanced
//		guard let index = items.index(of: item) else { return false }
		
		self.items.remove(at: index)
		
		return true
	}
}
