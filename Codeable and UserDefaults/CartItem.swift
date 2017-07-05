//
//  CartItem.swift
//  Codeable and UserDefaults
//
//  Created by Louis Tur on 7/5/17.
//  Copyright © 2017 AccessCode. All rights reserved.
//

import Foundation

struct CartItem: Codable {
	let name: String
	let sku: Int
	let price: Double
	
	init(name: String, sku: Int, price: Double) {
		self.name = name
		self.sku = sku
		self.price = price
	}
}
