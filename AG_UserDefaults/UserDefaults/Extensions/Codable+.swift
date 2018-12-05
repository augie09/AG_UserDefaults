//
//  Codable+.swift
//  AG_UserDefaults
//
//  Created by August Patterson on 10/28/18.
//  Copyright © 2018 AugustPatterson. All rights reserved.
//

import Foundation

extension Encodable {
    
    func encode() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}

