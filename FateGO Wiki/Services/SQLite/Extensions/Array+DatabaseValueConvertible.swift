//
//  Array+DatabaseValueConvertible.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

extension Array: DatabaseValueConvertible {
    /// Create a string as a plain value by its own `description`.
    ///
    ///     let arr = [1, 2, 3] // description "[1, 2, 3]"
    ///     let plainValue = "[1,2,3]" // with no blank.
    public var databaseValue: DatabaseValue {
        let value = description.replacingOccurrences(of: " ", with: "")
        return DatabaseValue(value: value)!
    }
    
    public static func fromDatabaseValue(_ dbValue: DatabaseValue) -> Array<Element>? {
        if case let .string(stringValue) = dbValue.storage {
            let elementType = Element.self
            
            if Int.self == elementType { // -> [Int]
                return stringValue[(1, -1)].split(separator: ",").map { Int($0)! as! Element }
            }
            
            if String.self == elementType { // -> [String]
                return stringValue[(1, -1)].split(separator: ",").map { String($0) as! Element }
            }
            
            if [Int].self == elementType { // -> [[Int]]
                return stringValue.split(separator: "[").map { $0[(0, -2)].split(separator: ",").map { Int($0)! } as! Element }
            }
            
            if [String].self == elementType { // -> [[String]]
                return stringValue.split(separator: "[").map { $0[(0, -2)].split(separator: ",").map { String($0) } as! Element }
            }
        }
        return nil
    }
    
    
}
