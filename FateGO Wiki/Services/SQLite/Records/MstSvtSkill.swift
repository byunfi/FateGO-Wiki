
//
//  MstSvtSkill.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct MstSvtSkill {
    let strengthStatus: Int
    let svtId: Int
    let num: Int
    let skillId: Int
    let condQuestId: Int
    let condQuestPhase: Int
    let condLv: Int
    let condLimitCount: Int
    let eventId: Int
    let flag: Int
}

extension MstSvtSkill: TableRecord {
    static var databaseTableName: String { "MstSvtSkill" }
    
    static let skill = hasOne(MstSkill.self)
}

extension MstSvtSkill: FetchableRecord {
    init(row: Row) {
        strengthStatus = row["strengthStatus"]
        svtId = row["svtId"]
        num = row["num"]
        skillId = row["skillId"]
        condQuestId = row["condQuestId"]
        condQuestPhase = row["condQuestPhase"]
        condLv = row["condLv"]
        condLimitCount = row["condLimitCount"]
        eventId = row["eventId"]
        flag = row["flag"]
    }
}
