//
//  FGOItem.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/11/1.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation

struct FGOItem {
    let id: Int
    let name: String
}

extension FGOItem: Hashable {
    static func == (lhs: FGOItem, rhs: FGOItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
