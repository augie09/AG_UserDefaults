//
//  UserDefaults+.swift
//  AG_UserDefaults
//
//  Created by August Patterson on 10/28/18.
//  Copyright © 2018 AugustPatterson. All rights reserved.
//


import UIKit

extension UserDefaults{
    
    func setValue<T: Codable>( _ value: T, key: String) throws {
        
        if isNativeType( T.self ) {
            self.set( value,
                      forKey: key)
        }
        else {
            try self.set( value.encode(),
                      forKey: key )
        }
    }
    
    func getValue<T: Codable>( key: String) -> T? {
        
        if isNativeType(T.self){
            return self.object(forKey: key) as? T
        }

        guard let data = self.data(forKey: key) else {
            return nil
        }
        
        return data.decode()

    }
    
   private func isNativeType<T: Codable>(_ type: T.Type) -> Bool {
        
        switch type {
        case is Bool.Type,
             is String.Type,
             is Int.Type,
             is Double.Type,
             is Float.Type,
             is Date.Type,
             is Data.Type:
            return true
        default:
            return false
        }
    }
}
