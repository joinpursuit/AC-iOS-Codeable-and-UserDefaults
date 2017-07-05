//
//  AppDelegate.swift
//  Codeable and UserDefaults
//
//  Created by Louis Tur on 6/29/17.
//  Copyright © 2017 AccessCode. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	
	var window: UIWindow?
	
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		
		// End of lesson exercise #1
		let defaults = UserDefaults.standard
		class LoggedInUser: Codable {
			var username: String
			var isPremium: Bool // if the user has a paid subscription
			var lastLogin: Date
			
			init(username: String, isPremium: Bool, lastLogin: Date = Date()) {
				self.username = username
				self.isPremium = isPremium
				self.lastLogin = lastLogin
			}
		}
		
		let user = LoggedInUser(username: "Louis", isPremium: true)
		let data = try! PropertyListEncoder().encode(user)
		defaults.set(data, forKey: "dataKey")
		
		let retrievedData = defaults.data(forKey: "dataKey")
		let retrievedUser = try! PropertyListDecoder().decode(LoggedInUser.self, from: retrievedData!)
		print(retrievedUser.username)
		
		// End of lesson exercise #2
		let cartItems: [CartItem] = [
			CartItem(name: "iPhone", sku: 999, price: 700.00),
			CartItem(name: "iMac", sku: 998, price: 2500.00),
			CartItem(name: "iPad", sku: 997, price: 800.00)
		]
		
		let cart = Cart(items: cartItems)
		let cartManager = CartStorageManager(cart: cart)
		
		cart.addItem(CartItem(name: "Macbook Air", sku: 996, price: 1200.00))
		_ = cart.items.map{
			print($0.name) // prints out 4 items, iPhone, iMac, iPad, Macbook Air
		}
		_ = cart.removeItem(cartItems[0])
		_ = cart.items.map{
			print($0.name) // prints out 3 items, iMac, iPad, Macbook Air
		}
		
		cartManager.saveCart()
		
		let newCart = CartStorageManager.loadCart()
		_ = newCart.items.map{
			print($0.name)
		}
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}
	
	
}

