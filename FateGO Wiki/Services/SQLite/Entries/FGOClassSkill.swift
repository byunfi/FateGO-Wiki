//
//  FGOClassSkill.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/11/1.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct FGOClassSkill {
    let skillId: Int
    let name: String
    let iconId: Int
    let effects: [FGOEffect]
}

extension FGOClassSkill: FetchableRecord {
    init(row: Row) {
        skillId = row["id"]
        name = row["name"]
        iconId = row["iconId"]
        let detail: [String] = row["detail"]
        let value: [[String]] = row["value"]
        effects = zip(detail, value).map(FGOEffect.init)
    }
}
