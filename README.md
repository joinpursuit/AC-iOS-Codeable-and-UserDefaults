# AC-iOS Codeable and UserDefaults (Swift 4.x)

---
### Readings
1. [Ultimate Guide to Parsing With Swift](http://benscheirman.com/2017/06/ultimate-guide-to-json-parsing-with-swift-4/?utm_campaign=iOS%2BDev%2BWeekly&utm_medium=email&utm_source=iOS_Dev_Weekly_Issue_306)
1. [An Introduction to NSUserDefaults](http://www.codingexplorer.com/nsuserdefaults-a-swift-introduction/)

### 0. Overall Goals

1. Become familiar with using `UserDefaults` to store data
2. Understand that `UserDefaults` is a light-weight, persistant storage option for small amounts of data that relate to how your app should be configured, based on the user's selection/choices. 
3. Become with the `Codeable` protocol that allows for easy conversion between Swift objects and storeable `Data`

### 1. `Codeable`: What a time to be alive!

Many of you will be starting your journey of Swift data serialization with some incredibly powerful and easy-to-use tools. I of course am refering to the `Codeable` protocol, introduced in Swift 4 to save developers from the agony that is de/serializing `Data`. 

#### Serialization: What is it?

Serialization, in development, refers to converting an object/struct/var into raw data, essentially 0's and 1's (well, 0's and F's). Serialization is performed when you need to store language/code-specific objects into persistant storage. Then later, when you need to retrieve the object from memory you de-serialize it, meaning you convert it from its raw binary back into useable objects in code. 

#### Serialization: Where does it happen?

All over. But one very common scenario is making `URLRequest`s. Remember how the completion handlers for our network requests looked like:

```swift
func makeRequest(completion: (Data?)-> Void) {
	// ... awesome code ...
}
```

They took a parameter of `Data?` because a response sent back from an API is all raw data! It's up to our code to **deserialize** it so that we can use it in our apps. Thats what `JSONSerialization` was being used for! It should be easy to see why that class was named the way it was: it's tasked with deserializing json-formatted `Data` into a Swift-useable type, `Any`. 

Another place it is commonly used is to store/retrieve information from `UserDefaults`, which is what we're going to take a look at first.

---
### 2. `UserDefaults`: Light-weight, simple persistant storage

The intended use of `UserDefaults` is in the name: you want to store a user's default preferences when using your app. For example, suppose your app offered a "night mode". A user might only want to use your app in "night mode" because it's easier for them to read. It wouldn't be a great experience for them, however, if they had to switch the app into "night mode" every time they opened the app. Instead, you store the user's preference for using "night mode" in `UserDefaults` and then every time your app launches you retrieve that stored information and update your app before it finishes launching. 

![Regular and Dark Mode, Side-By-Side, Twitter](./Images/light_night_twitter.jpg)
##### **via [Slashgear](https://www.slashgear.com/twitter-night-mode-activated-on-ios-and-android-22452842/)**

#### Where does `Codeable` come in?

`UserDefaults` is a really great option for storing simple data types -- in fact, it only can natively store Swift or Foundation types. This includes (these Foundation objects are bridged to their Swift equivalents):

- NSData
- NSString
- NSNumber
	- UInt
	- Int
	- Float
	- Double
	- Bool
- NSDate
- NSArray
- NSDictionary

The tricky part is if you want to store objects that you've defined in code. 

---
### 3. Trying out `UserDefaults`

> Note: We're going to be writing this code inside of `didFinishLaunching` in the `AppDelegate.swift` file.

Let's take a look at a few basic examples of storing and retrieving data.

It all begins with the `standard` singleton:

```swift
let defaults = UserDefaults.standard
```

> Note: It's possible to define a separate `UserDefaults` by creating one with a new id, but unnecessary for our purposes. 

From here, it's as simple as calling `set(_:forKey:)` function on `defaults` in order to store data:

```swift
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
```

Retrieving that data is only slightly more work since you need to account for optionals and types:

```swift
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
```

![Retrieval of values](./Images/userdefaults_retrieval.png)

Let's try a few out now:

#### Practice

**Instructions:** For each of these data structures, you must store them to `UserDefaults` and ensure that you can retrieve and print their properties just as we did in the first set of sample code:

```swift
// 1. 
let numbersArr = [2, 4, 5, 6, 7, 10]

// 2. 
let dates = [Date(), Date(), Date(), Date()]

// 3.
let largerDict = [
	"name" : "Louis",
	"cats_name" : "Miley",
	"location" : "Queens"
	]

// 4. 
let mixedTypeDict: [String : Any] = [
	"name" : "Miley",
	"breed" : "American Shorthair",
	"age" : 5
	]

// 5.
let nestedArray = [
	[1, 2, 3, 4, 5],
	[10, 20, 30, 40, 50],
	[11, 12, 13, 14]
	]

// 6.
let nestedDictionary = [
	"cat" : [
		"name" : "Miley"
		],

	"dog" : [
		"name" : "Spot"
		]
	]

// 7. 
let nestedStructure = [
	"cats" : [
		[ 	"name" : "Miley",
			"age"  : 5 ],
		[	"name" : "Bale",
			"age" : 14]
		]
	]

// 8. ~~ Advanced ~~
let advancedStructure: [String : Any] = [
	"cats" : [
		[	"name" : "Miley",
			"age"  : 5 		],
		[	"name" : "Bale",
			"age" : 14		]	],

	"dogs" : [
		[	"breed" : "Basset Hound",
			"age"  : 7 	],
		[	"breed" : "Greyhound",
			"age" : 3	]	],

	"stats" : [
		"scale" : "miles",
		"distance_to_sun" : 92.96,
		"distance_to_moon" : 238900
	]
]
```







