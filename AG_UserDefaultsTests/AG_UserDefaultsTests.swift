//
//  AG_UserDefaultsTests.swift
//  AG_UserDefaultsTests
//
//  Created by August Patterson on 12/5/18.
//  Copyright © 2018 AugustPatterson. All rights reserved.
//

import XCTest
@testable import AG_UserDefaults

class UserDefaultTests: XCTestCase {
    
    var userDefaults : UserDefaults!
    
    override func setUp() {
        userDefaults = UserDefaults.standard
    }
    
    override func tearDown() {
        userDefaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        userDefaults.synchronize()
    }
    
    func testBool() {
        let bool = true
        UserDefaultKeys.testBool.setValue(bool)
        XCTAssert( bool == UserDefaultKeys.testBool.getValue() )
    }
    
    func testNamesapce() {
        let k = "key"
        let date = Date()
        userDefaults.setValue(date, forKey: k)
        let date2 : Date? = userDefaults.value(forKey: k) as? Date
        
        XCTAssert( date == date2)
        
        let bool = true
        userDefaults.setValue(bool, forKey: k)
        let date3 : Date? = userDefaults.value(forKey: k) as? Date
        
        XCTAssert( date != date3)
    }
    
    func testString() {
        let string = "happy go lucky\n merrily merrily"
        UserDefaultKeys.testString.setValue(string)
        XCTAssert( string == UserDefaultKeys.testString.getValue() )
    }
    
    func testInt() {
        let int = 888
        UserDefaultKeys.testInt.setValue(int)
        XCTAssert( int == UserDefaultKeys.testInt.getValue() )
    }
    
    func testDouble() {
        let double : Double = 0.035
        UserDefaultKeys.testDouble.setValue(double)
        XCTAssert( double == UserDefaultKeys.testDouble.getValue() )
    }
    
    func testFloat() {
        let float : Float = 888.035
        UserDefaultKeys.testFloat.setValue(float)
        XCTAssert( float == UserDefaultKeys.testFloat.getValue() )
    }
    
    func testDate() {
        let date = Date.distantPast
        UserDefaultKeys.testDate.setValue(date)
        XCTAssert( date == UserDefaultKeys.testDate.getValue() )
    }
    
    func testData() {
        let data : Data = "olay olay olay".data(using: .utf8)!
        UserDefaultKeys.testData.setValue(data)
        XCTAssert( data == UserDefaultKeys.testData.getValue() )
    }
    
    func testNil() {
        XCTAssertNil(UserDefaultKeys.myNFLTeam.getValue())
    }
    
    func testBadData() {
        let data : Data = "olay olay olay".data(using: .utf8)!
        userDefaults.setValue(data, forKey: "myNFLTeam")
        XCTAssertNil(UserDefaultKeys.myNFLTeam.getValue())
    }
    
    func testTwoUserDefaultInstances() {
        
        let myAppsOpenCount = UserDefaultInt.init(key: "openCount", userDefaults: userDefaults)
        let extensOpenCount = UserDefaultInt.init(key: "openCount", userDefaults: UserDefaults.init(suiteName: "custom")!)
        
        myAppsOpenCount.setValue(50)
        extensOpenCount.setValue(49)
        
        XCTAssert( myAppsOpenCount.getValue() != extensOpenCount.getValue() )
    }
    
    func testCustomObject() {
        let myTeam = NFLTeam.init(name: "49ers",
                                  founded: Date(),
                                  hasWonSuperBowl: true)
        UserDefaultKeys.myNFLTeam.setValue(myTeam)
        XCTAssert( myTeam == UserDefaultKeys.myNFLTeam.getValue() )
    }
    
}

extension UserDefaultKeys {
    
    static var testBool : UserDefaultBool = "testBool"
    static var testString : UserDefaultString = "testString"
    static var testInt : UserDefaultInt = "testInt"
    static var testDouble : UserDefaultDouble = "testDouble"
    static var testFloat : UserDefaultFloat = "testFloat"
    static var testDate : UserDefaultDate = "testDate"
    static var testData : UserDefaultData = "testData"
    static var myNFLTeam : UserDefaultNFLTeam = "myNFLTeam"
    
}


struct NFLTeam : Codable {
    var name: String
    var founded: Date
    var hasWonSuperBowl: Bool
}

extension NFLTeam : Equatable {
    static func == (lhs: NFLTeam, rhs: NFLTeam) -> Bool {
        return
            lhs.name == rhs.name &&
                lhs.founded == rhs.founded &&
                lhs.hasWonSuperBowl == rhs.hasWonSuperBowl
    }
}

final class UserDefaultNFLTeam :  UserDefaultKeyTypeBaseClass, UserDefaultKeyType{
    typealias ValueType = NFLTeam
}
