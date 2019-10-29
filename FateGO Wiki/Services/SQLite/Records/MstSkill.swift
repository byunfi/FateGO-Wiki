//
//  MstSkill.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct MstSkill {
    let id: Int
    let type: Int
    let jpName: String
    let maxLv: Int
    let iconId: Int
    let name: String
}

extension MstSkill: TableRecord {
    static var databaseTableName: String { "MstSkill" }
    
    static let detail = hasOne(MstSkillDetail.self)
    static let lv = hasOne(MstSkillLv.self)
}

extension MstSkill: FetchableRecord {
    init(row: Row) {
        id = row["id"]
        type = row["type"]
        jpName = row["jpName"]
        maxLv = row["maxLv"]
        iconId = row["iconId"]
        name = row["name"]
    }
}
