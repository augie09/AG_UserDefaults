//
//  UserDefaultKeyTypes.swift
//  AG_UserDefaults
//
//  Created by August Patterson on 10/28/18.
//  Copyright © 2018 AugustPatterson. All rights reserved.
//

import UIKit

/// Protocol for UserDefaults that binds keys to valueTypes
protocol UserDefaultKeyType : ExpressibleByStringLiteral {
    
    associatedtype ValueType : Codable
    
    /// Key for storing in UserDefaults
    var key : String {get set}
    
    /// An instance of UserDefaults to use
    var userDefaults : UserDefaults { get }
    
    /// Init without dependency injection
    ///
    /// - Parameter key: UserDefault Key
    init(key:String)
    
    /// stores value in UserDefaults instance
    ///
    /// - Parameter value: The ValueType defined for this UserDefaultKeyType instance
    func setValue(_ value: ValueType)
    
    /// gets a value from UserDefaults instance
    ///
    /// - Returns: The ValueType defined for this UserDefaultKeyType instance
    func getValue() -> ValueType?
    
}

/// Default Implementations, relying on UserDefaults+ generic functions
extension UserDefaultKeyType {

    /// stores value in UserDefaults instance
    ///
    /// - Parameter value: The ValueType defined for this UserDefaultKeyType instance
    func setValue(_ value: ValueType){
        try! userDefaults.setValue(value, key: self.key)
    }
    
    /// gets a value from UserDefaults instance
    ///
    /// - Returns: The ValueType defined for this UserDefaultKeyType instance
    func getValue() -> ValueType?{
        return userDefaults.getValue(key: self.key)
    }
    
    /// String Literal initializer, for a pretty little protocol
    ///
    /// - Parameter value: UserDefault key
    init(stringLiteral value: String) {
        self = Self.init(key: value )
    }
}

/// Define variables that all UserDefaultsKeyType's will have
public class UserDefaultKeyTypeBaseClass {
    /// Key for storing in UserDefaults
    var key: String
    /// An instance of UserDefaults to use
    var userDefaults: UserDefaults
    
    /// Init without dependency injection
    ///
    /// - Parameter key: UserDefault Key
    init(key: String ){
        self.key = key
        self.userDefaults = UserDefaults.standard
    }

    /// Init with dependency injection
    ///
    /// - Parameters:
    ///   - key: UserDefault Key
    ///   - userDefaults: UserDefault instance to use, defaults to standard
    init(key: String, userDefaults: UserDefaults = UserDefaults.standard ){
        self.key = key
        self.userDefaults = userDefaults
    }
}

//MARK:- Concrete UserDefaultKey types to be used in UserDefaultKeys
// Note that you can define additional ones as long as the ValueType conforms to Codable
/// UserDefaultKeyType binding for Bool
final class UserDefaultBool :  UserDefaultKeyTypeBaseClass, UserDefaultKeyType{
    typealias ValueType = Bool
}
/// UserDefaultKeyType binding for String
final class UserDefaultString :  UserDefaultKeyTypeBaseClass, UserDefaultKeyType{
    typealias ValueType = String
}
/// UserDefaultKeyType binding for Int
final class  UserDefaultInt :  UserDefaultKeyTypeBaseClass, UserDefaultKeyType{
    typealias ValueType = Int
}
/// UserDefaultKeyType binding for Double
final class  UserDefaultDouble :  UserDefaultKeyTypeBaseClass, UserDefaultKeyType{
    typealias ValueType = Double
}
/// UserDefaultKeyType binding for Float
final class  UserDefaultFloat :  UserDefaultKeyTypeBaseClass, UserDefaultKeyType{
    typealias ValueType = Float
}
/// UserDefaultKeyType binding for Date
final class  UserDefaultDate :  UserDefaultKeyTypeBaseClass, UserDefaultKeyType{
    typealias ValueType = Date
}
/// UserDefaultKeyType binding for Data
final class  UserDefaultData :  UserDefaultKeyTypeBaseClass, UserDefaultKeyType{
    typealias ValueType = Data
}
