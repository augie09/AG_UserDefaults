//
//  UserDefaultKeys.swift
//  AG_UserDefaults
//
//  Created by August Patterson on 10/28/18.
//  Copyright © 2018 AugustPatterson. All rights reserved.
//
//  Overview:
//      UserDefaultKeys contains every UserDefaultKeyType used
//      UserDefaultKeys maintains Namespace by associating each UserDefaultKeyType as a static var
//      Extend UserDefaultKeys in your app to add more UserDefaultKeyTypes
//      USerDefaultKeyType protocol leverages UserDefaults+ to maintain type safety
//
//
//  Storing Custom Types
//      UserDefaultKeys can handle custom object types if they conform to Codable protocol
//      Example:
//        // Some Custom Object conforming to Codable
//        struct NFLTeam : Codable {
//            var name: String
//            var founded: Date
//            var hasWonSuperBowl: Bool
//        }
//
//        // Step 1: Create a UserDefaultKeyType for the Custom Object
//        final class UserDefaultNFLTeam :  UserDefaultKeyTypeBaseClass, UserDefaultKeyType{
//            typealias ValueType = NFLTeam
//        }
//
//        // Step 2: Add static var to store an instance of custom object
//        extensin UserDefaultKeys {
//            static var myNFLTeam : UserDefaultNFLTeam = "myNFLTeam"
//        }
//
//        // Step 3: Test :)
//        let myTeam = NFLTeam.init(name: "49ers",
//                                        founded: Date(),
//                                        hasWonSuperBowl: true)
//        UserDefaultKeys.myNFLTeam.setValue(myTeam)
//        let myTeam = UserDefaultKeys.myNFLTeam.getValue()
//        print(myTeam)
//
//        Initializing via String Literal
//        static var myCustomString : UserDefaultString = "myCustomString"
//
//        Initializing via init(key:) - this defaults ot UserDefaults.standard
//        static var myCustomBool = UserDefaultBool.init(key: "myCustomBool")
//
//        Initializing via init(key: userDefaults:) to inject a UserDefaults instance
//        static var myCustomInt = UserDefaultInt.init(key: "myCustomInt", userDefaults: UserDefaults.Standard)
//

import Foundation

/// Struct that holds all UserDefaultKeyType bindings.  Extend this as needed to add more custom ones for your app
struct UserDefaultKeys {
    
    static var lastInstalledVersion : UserDefaultString = "lastInstalledVersion" // Should be set in AppDelegate application(_:didFinishLaunchingWithOptions:)
    
}

