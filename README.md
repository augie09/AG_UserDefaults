# AG_UserDefaults

## Overview

This started out as a test to see if I could bind valye types to keys and achieve key namespace safety.  
I am now using this in my personal projects and a very close replica in professional projects.  
Figured it's at a good enough point to share. 

### Goal 
- User Default Keys should be bound to a specific type, which is any type that conforms to Codable.
- User Default Keys should be defined in a centralized structure, which can be extended by other modules/components/apps as needed.  Sorry, no enums since extension is a requirement
- If a developer tries to set or get a type not bound to that key, they should see a pre-compile error immediately in Xcode

## Usage

Basic
```
//Define a Key and bind its value to a type
//Note: Make static var name = string literal to maintain namespace for key
extension UserDefaultKeys {
     static var preferredName : UserDefaultString = "preferredName"   // UserDefaultKeys.preferredName set and get will always be String
}

// Set a value
UserDefaultKeys.preferredName.setValue("Bobbie Wasabi")  // only Strings will be allowed

// Get a value
let name = UserDefaultKeys.preferredName.getValue()  // type will be String
```

The following key types are provided
```
UserDefaultBool
UserDefaultData
UserDefaultDate
UserDefaultDouble
UserDefaultFloat
UserDefaultInt
UserDefaultString
```

How to create key types for custom objects
- requirement: custom object must conform to Codable protocol
```
// Some Custom Object conforming to Codable
struct NFLTeam : Codable {
     var name: String
     var founded: Date
     var hasWonSuperBowl: Bool
}

// Step 1: Create a UserDefaultKeyType for the Custom Object
final class UserDefaultNFLTeam :  UserDefaultKeyTypeBaseClass, UserDefaultKeyType{
     typealias ValueType = NFLTeam
}

// Step 2: Add static var to store an instance of custom object
extensin UserDefaultKeys {
     static var myNFLTeam : UserDefaultNFLTeam = "myNFLTeam"
}

// Step 3: Test :)
let myTeam = NFLTeam.init(name: "49ers",
     founded: Date(),
     hasWonSuperBowl: true)
UserDefaultKeys.myNFLTeam.setValue(myTeam)
let myTeam = UserDefaultKeys.myNFLTeam.getValue()  // type will be NFLTeam
print(myTeam.name)
```

## How to add to a project
Copy these 4 files to your project
- UserDefaultKeyTypes.swift
- UserDefaultKeys.swift
- UserDefaults+.swift
- Codable+.swift
- Data+.swift

## Unit Tests
    There is 100% test coverage for the files providing UserDefuault functionality
    - UserDefaultKeyTypes.swift
    - UserDefaults+.swift
    - Codable+.swift
    - Data+.swift
    

