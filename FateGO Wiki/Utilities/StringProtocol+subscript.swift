//
//  StringProtocol+subscript.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation

extension StringProtocol {
    subscript(range: (l: Int, r: Int)) -> Self.SubSequence {
        let start = intToIndex(range.l)
        let end = intToIndex(range.r)
        return self[start..<end]
    }
    
    subscript(range: ClosedRange<Int>) -> Self.SubSequence {
        get {
            let start = intToIndex(range.lowerBound)
            let end = intToIndex(range.upperBound)
            return self[start...end]
        }
    }
    
    subscript(range: Range<Int>) -> Self.SubSequence {
        get {
            let start = intToIndex(range.lowerBound)
            let end = intToIndex(range.upperBound)
            return self[start..<end]
        }
    }
    
    subscript(range: PartialRangeFrom<Int>) -> Self.SubSequence {
        get {
            let start = intToIndex(range.lowerBound)
            return self[start...]
        }
    }
    
    subscript(range: PartialRangeThrough<Int>) -> Self.SubSequence {
        get {
            let end = intToIndex(range.upperBound)
            return self[...end]
        }
    }
    
    subscript(range: PartialRangeUpTo<Int>) -> Self.SubSequence {
        get {
            let end = intToIndex(range.upperBound)
            return self[..<end]
        }
    }
    
    private func intToIndex(_ i: Int) -> Index {
        let res = index(i >= 0 ? startIndex: endIndex, offsetBy: i)
        return res
    }
}

