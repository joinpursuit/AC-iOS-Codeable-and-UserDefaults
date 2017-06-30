# AC-iOS Codable and UserDefaults (Swift 4.x)

---
### Readings
1. [Ultimate Guide to Parsing With Swift](http://benscheirman.com/2017/06/ultimate-guide-to-json-parsing-with-swift-4/?utm_campaign=iOS%2BDev%2BWeekly&utm_medium=email&utm_source=iOS_Dev_Weekly_Issue_306)
1. [An Introduction to NSUserDefaults](http://www.codingexplorer.com/nsuserdefaults-a-swift-introduction/)

### 0. Overall Goals

1. Become familiar with using `UserDefaults` to store data
2. Understand that `UserDefaults` is a light-weight, persistant storage option for small amounts of data that relate to how your app should be configured, based on the user's selection/choices.
3. Become with the `Codable` protocol that allows for easy conversion between Swift objects and storeable `Data`

### 1. `Codable`: What a time to be alive!

Many of you will be starting your journey of Swift data serialization with some incredibly powerful and easy-to-use tools. I of course am refering to the `Codable` protocol, introduced in Swift 4 to save developers from the agony that is de/serializing `Data`.

#### Serialization: What is it?

Serialization, in development, refers to converting an object/struct/var into raw data, essentially 0's and 1's (well, 0's and F's). Serialization is performed when you need to store language/code-specific objects into persistant storage. Then later, when you need to retrieve the object from memory you de-serialize it, meaning you convert it from its raw binary back into useable objects in code.

#### Serialization: Where does it happen?

All over. But one very common scenario is making `URLRequest`s. Remember how the completion handlers for our network requests looked like:

```swift
func makeRequest(completion: @escaping (Data?)-> Void) {
	// ... awesome code ...
}

```

They took a parameter of `Data?` because a response sent back from an API is all raw data! It's up to our code to **deserialize** it so that we can use it in our apps. Thats what `JSONSerialization` was being used for! It should be easy to see why that class was named the way it was: it's tasked with deserializing json-formatted `Data` into a Swift-useable type, `Any`.

Another place it is commonly used is to store/retrieve information from `UserDefaults`, which is what we're going to take a look at first.

---
### 2. `UserDefaults`: Light-weight, simple persistant storage

The intended use of `UserDefaults` is in the name: you want to store a user's default preferences when using your app. For example, suppose your app offered a "night mode". A user might only want to use your app in "night mode" because it's easier for them to read. It wouldn't be a great experience for them, however, if they had to switch the app into "night mode" every time they opened the app. Instead, you store the user's preference for using "night mode" in `UserDefaults` and then every time your app launches you retrieve that stored information and update your app before it finishes launching.

![Regular and Dark Mode, Side-By-Side, Twitter](./Images/light_dark_twitter.jpg)
##### **via [Slashgear](https://www.slashgear.com/twitter-night-mode-activated-on-ios-and-android-22452842/)**

#### Where does `Codable` come in?

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

---
### 4. `Codable` Storage

Let's say we have an object called `ReadingPreference` that is suppose to track a user's preferences when reading in an app:

```swift
class ReadingPreference {
	var fontName: String
	var fontSize: Float
	var darkMode: Bool

	init(fontName: String, fontSize: Float, darkMode: Bool) {
		self.fontName = fontName
		self.fontSize = fontSize
		self.darkMode = darkMode
	}
}

let preferences = ReadingPreference(fontName: "Menlo", fontSize: 16.0, darkMode: true)
```

Ideally, we'd like to store this object in `UserDefaults` so that we can load this information every time the app launches. We know that `UserDefaults.set(_:forKey:)` accepts an object of type `Any` and `UserDefaults.object(forKey:)` returns `Any`, so why don't we try to store that info like so:

```swift
let defaults = UserDefaults.standard
defaults.set(preferences, forKey: "readingPreferencesKey")

// later to load it up:
let preference = defaults.object(forKey: "readingPreferencesKey") as! ReadingPreference
```

Go ahead and run this...

![Non-Swift Type UserDefaults Error](./Images/userdefaults_throws.png)

What happened exactly? Remember that `UserDefaults` has no problem storing native Swift data types listed earlier. What it *cannot* do is store custom objects that you've defined in code. If you try to do this, an exception is thrown and your app will crash. Though, to get around this, we can (very) simply implement the `Codable` protocol:

```swift
// WHAT? all we do is add the Codable protocol and nothing else??? 👍
class ReadingPreference: Codable {
	var fontName: String
	var fontSize: Float
	var darkMode: Bool

	init(fontName: String, fontSize: Float, darkMode: Bool) {
		self.fontName = fontName
		self.fontSize = fontSize
		self.darkMode = darkMode
	}
}
```

The core component of the `Codable` protocol is that so long as the properties of an object that conforms to `Codable` are Swift types, you get a free `Dictionary` representation of your object.

> **Important:** `Codable` is a protocol that combines two other relavent protocols, `Encodable` and `Decodable`. Semantically, this means that an object which is "codable" should be both able to be "encoded" and "decoded." Remember that here, encoding/decoding are synonyms for serializing/deserializing

Now, there's still a little work that needs to be done in order to convert a `ReadingPreference` object into a data type that works with `UserDefaults`, but not terribly much work:

```swift
let preferences = ReadingPreference(fontName: "Menlo", fontSize: 16.0, darkMode: true)

// 1.
let encodedPreferences = try! PropertyListEncoder().encode(preferences)

// 2.
defaults.set(encodedPreferences, forKey: "encodedPreferences")

// 3.
let encoded = defaults.object(forKey: "encodedPreferences") as! Data

// 4.
let storedPrefs = try! PropertyListDecoder().decode(ReadingPreference.self, from: encoded)

print("\n\n\n\n\n\n\n")
print("Stored Preferences: \n\(storedPrefs.fontName), \(storedPrefs.fontSize), \(storedPrefs.darkMode)")
```

1. We make use of `PropertyListEncoder` which works with objects that conform to `Encodable` in order to create a `Data` object. `encode(_:)` can `throw` so we mark it with `try`
2.  `Data` is one of the Swift types that `UserDefaults` can store, so we call `set(_:forKey:)`
3. When we wish to retrieve the object, we call `object(forKey:)` which returns `Any?`. We know it is `Data` so we force cast it.
4. Lastly, we use `PropertyListDecoder.decode(_:from:)`. `decode(_:from:)` takes an object that is type of `Decodable.Protocol` in order to know what it should try to make the `Data` into. This also can `throw` so it is marked with a `try`

![Codable Working](./Images/codable_prefs.png)

Kinda amazing... there's a lot of powerful magic going on with this protocol. Someday, you should go and look up the source code for it.  But for now, let's just play around with some code examples:

---
### 6.  `Codable` Exercises

>>> TODO



Roadmap:
1. Write a few exercises in codeable
2. Return to `Codable` with JSON
3. Include caveat to nesting







---
###  5. `Codable` with `JSON`

Now for some real magic: we can use Codable to serialize and deserialize JSON incredibly easily.

#### The Old Way

As we have in the past, we're going to use the [RandomUser API](https://randomuser.me/documentation) for these examples. First, we're going to make a simple request to receive a JSON object of a single user's name information:

`https://randomuser.me/api/?inc=name&noinfo`

1. The `inc` key lets you specify the information your specifically interested in receiving, in this case we just want randomly generated `name` info
2. The `noinfo` removes additional unnecessary key/values from the response as well.

> Note: Go ahead and plug in the above URL into postman to observer the results. Below is an example of the full JSON we will receive.

```json
{
    "results": [
        {
            "name": {
                "title": "mr",
                "first": "simon",
                "last": "bernard"
            }
        }
    ]
}
```

As a reminder, here is the code we're previously used in order to parse JSON and define a model object (I've provided you with a sample `User` struct)

```swift
struct User {
	let title: String
	let firstName: String
	let lastName: String

	var fullName: String {
		return "\(title.capitalized) \(firstName.capitalized) \(lastName.capitalized)"
	}
}

// Function calls the API and returns Optional Data
func makeRequest(completion: @escaping (Data?)-> Void) {

	let session = URLSession.shared
	session.dataTask(with: URL(string: "https://randomuser.me/api/?inc=name&noinfo")!) { (data: Data?, _, _) in
		completion(data)
	}.resume()
}

// Function starts the process for getting a single user, parses out data from makeRequest if not nil
func retrieveUser() {
	makeRequest { (data: Data?) in
		if data != nil {
			do {
				let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]

				if let resultsJSON = json["results"] as? [[String:AnyObject]] {
					for result in resultsJSON {
						if let nameJSON = result["name"] as? [String:String] {
							guard let title = nameJSON["title"],
								let first = nameJSON["first"],
								let last = nameJSON["last"] else {
									return
							}

							let newUser = User(title: title, firstName: first, lastName: last)
							print("Hi, i'm \(newUser.fullName)")
						}
					}
				}

			}
			catch {
				print("Error casting from Data to JSON \(error)")
			}
		}
	}
}
```

We've even taken things one step further by adding an additional `init(json: [String:String])` to our `User` struct and removing some of that nasty, typecasting code out of our API request functions:

```swift
struct User {
	let title: String
	let firstName: String
	let lastName: String

	var fullName: String {
		return "\(title.capitalized) \(firstName.capitalized) \(lastName.capitalized)"
	}

	// For simplicity, we force unwrap here, but you should unwrap optionals safely under normal circumstance
	init(json: [String:AnyObject]) {
		let nameJSON = json["name"] as! [String:String]
		let title = nameJSON["title"]
		let first = nameJSON["first"]
		let last = nameJSON["last"]

		self.init(title: title!, first: first!, last: last!)
	}

	// The initializer we get for "free" needs to be re-added should we add our own custom inits
	init(title: String, first: String, last: String) {
		self.title = title
		self.firstName = first
		self.lastName = last
	}
}

func retrieveUser() {
	makeRequest { (data: Data?) in
		if data != nil {
			do {
				let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]

				if let resultsJSON = json["results"] as? [[String:AnyObject]] {
					for result in resultsJSON {
						let newUser = User(json: result)
						print("Hi, i'm \(newUser.fullName)")
					}
				}
			}
			catch {
				print("Error casting from Data to JSON \(error)")
			}
		}
	}
}

func makeRequest(completion: @escaping (Data?)-> Void) {
	let session = URLSession.shared
	session.dataTask(with: URL(string: "https://randomuser.me/api/?inc=name&noinfo")!) { (data: Data?, _, _) in
		completion(data)
	}.resume()
}
```

#### The Codable Way

JSON is at its core a `Dictionary`, and all of our parsing from `Data` to `Dictionary<Hashable:Any>` involves traversing through its dictionary-like structure once we convert raw serialized data from a `URLRequest` into `Data` and from `Data` into `Any`. Having `Codable` makes this conversion trivial. Let's take a look:

```swift
struct User: Codable {
	let title: String
	let firstName: String
	let lastName: String

	var fullName: String {
		return "\(title.capitalized) \(firstName.capitalized) \(lastName.capitalized)"
	}
}
```

*Eventually*, we're going to want to convert the `Data?` returned from a `URLRequest` into one or more `User`. Though we're going to work backward by first attempting to converting a `User` into `Data`. :

```swift
let user = User(title: "Mr", firstName: "Louis", lastName: "Tur")
let encodedUserData = try! PropertyListEncoder().encode(user)

print("\n\n\n\n\nThe user is now data: \(encodedUserData)")
```

Ok, that was easy enough. How about doing the reverse now:

```swift
let decodedUser = try! PropertyListDecoder().decode(User.self, from: encodedUserData)
print("The user is no longer data: \(decodedUser)")
```

![Converting User using Codable](./Images/user_to_data_and_back.png)

>>>> TODO:
1. Attempt to update code in existing request
2. explain need for nesting considerations
3. exercises! include nesting, using custom keys, enums/structs, and advanced will be dynamic keys