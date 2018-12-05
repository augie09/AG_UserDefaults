//
//  Data+.swift
//  AG_UserDefaults
//
//  Created by August Patterson on 10/28/18.
//  Copyright © 2018 AugustPatterson. All rights reserved.
//

import Foundation

extension Data {
    
    func decode<T:Codable>() -> T?{
        
        guard let t = try? JSONDecoder().decode(T.self, from: self) else {
            return nil
        }
        return t
    }
}
