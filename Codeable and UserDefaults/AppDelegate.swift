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
        
        enum CatBreed: String, Codable {
            case americanShortHair, russianBlue
        }
        
        struct Cat: Codable {
            let name: String
            let age: Int
            let breed: CatBreed
        }
        
        //        let cat1 = Cat(name: "Louis", age: 2, breed: .americanShortHair)
        //        let defaults = UserDefaults.standard
        //
        //        let catList = try! PropertyListEncoder().encode(cat1)
        //        defaults.set(catList, forKey: "cat1")
        //        defaults.synchronize()
        //
        //        let retrievedCat1 = defaults.value(forKey: "cat1") as! Data
        //        let decodedCat1 = try! PropertyListDecoder().decode(Cat.self, from: retrievedCat1)
        //        print(decodedCat1)
        
        
        let defaults = UserDefaults.standard
        
        
        // store a string
        let string = "Hello, World"
        defaults.set(string, forKey: "stringKey")
        
        // store a number
        let number = 10
        defaults.set(number, forKey: "numbersKey")
        
        // store an array
        let arr = ["Hello", "World"]
        defaults.set(arr, forKey: "arrKey")
        
        // store a dict
        let dict = ["Hello" : "World"]
        defaults.set(dict, forKey: "dictKey")
        
        // retrieve a string
        if let aString = defaults.value(forKey: "stringKey") as? String {
            print("String Retrieved: \(aString)")
        }
        
        // retrieve a number
        if let aNumber = defaults.value(forKey: "numbersKey") as? Int {
            print("Number Retrieved: \(aNumber)")
        }
        
        // retrieve an array
        if let aArr = defaults.value(forKey: "arrKey") as? [String] {
            print("Array Retrieved: \(aArr)")
        }
        
        // retrieve a dict
        if let aDict = defaults.value(forKey: "dictKey") as? [String:String] {
            print("Dictionary Retrieved: \(aDict)")
        }
        
        // nested types
        let numbersArr = [2, 4, 5, 6, 7, 10]
        
        let dates = [Date(), Date(), Date(), Date()]
        
        let largerDict = [
            "name" : "Louis",
            "cats_name" : "Miley",
            "location" : "Queens"
        ]
        
        let mixedTypeDict: [String : Any] = [
            "name" : "Miley",
            "breed" : "American Shorthair",
            "age" : 5
        ]
        
        let nestedArray = [
            [1, 2, 3, 4, 5],
            [10, 20, 30, 40, 50],
            [11, 12, 13, 14]
        ]
        
        let nestedDictionary = [
            "cat" : [
                "name" : "Miley"
            ],
            "dog" : [
                "name" : "Spot"
            ]
        ]
        
        let nestedStructure = [
            "cats" : [
                [ "name" : "Miley",
                  "age"  : 5 ],
                [ "name" : "Bale",
                  "age" : 14]
            ]
        ]
        
        let advancedStructure: [String : Any] = [
            "cats" : [["name" : "Miley",
                       "age"  : 5 ],
                      ["name" : "Bale",
                       "age" : 14]],
            "dogs" : [["breed" : "Basset Hound",
                       "age"  : 7 ],
                      ["breed" : "Greyhound",
                       "age" : 3]],
            "stats" : [
                "scale" : "miles",
                "distance_to_sun" : 92.96,
                "distance_to_moon" : 238900
            ]
        ]
        
        defaults.set(nestedStructure, forKey: "nestedKey")
        
        if let nestedDict = defaults.value(forKey: "nestedKey") as? [String:AnyObject] {
            if let catsArray = nestedDict["cats"] as? [[String : AnyObject]] {
                for cat in catsArray {
                    if let name: String = cat["name"] as? String,
                        let age: Int = cat["age"] as? Int {
                        print("Cat found: \(name), \(age)")
                    }
                }
            }
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

