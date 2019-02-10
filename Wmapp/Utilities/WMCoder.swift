//
//  WMCoder.swift
//  Wmapp
//
//  Created by Seref Bulbul on 6.02.2019.
//  Copyright © 2019 Seref Bulbul. All rights reserved.
//

import Foundation

class WMCoder {
    
    static func encode<T: Encodable>(data: T) -> Data? {
        let encoder = JSONEncoder()
        
        do {
            return try encoder.encode(data)
        } catch {
            return nil
        }
    }
    
    static func decode<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let decoded = try decoder.decode(type, from: data)
            return decoded
        } catch {
            return nil
        }
    }
    
}
