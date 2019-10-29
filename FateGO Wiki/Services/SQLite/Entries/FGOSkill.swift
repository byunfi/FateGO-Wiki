//
//  FGOSkill.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/31.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct FGOSkill {
    let skillId: Int
    let num: Int
    let name: String
    let iconId: Int
    let chargeTurn: Int
    let maxLv: Int
    let effects: [FGOEffect]
    let strengthStatus: Int
    let flag: Int
    let condQuestId: Int
    let condQuestPhase: Int
    let condLv: Int
    let condLimitCount: Int
}

extension FGOSkill: FetchableRecord {
    init(row: Row) {
        skillId = row["skillId"]
        num = row["num"]
        name = row["name"]
        iconId = row["iconId"]
        chargeTurn = row["chargeTurn"]
        maxLv = row["maxLv"]
        let detail: [String] = row["detail"]
        let value: [[String]] = row["value"]
        effects = zip(detail, value).map(FGOEffect.init)
        strengthStatus = row["strengthStatus"]
        flag = row["flag"]
        condQuestId = row["condQuestId"]
        condQuestPhase = row["condQuestPhase"]
        condLv = row["condLv"]
        condLimitCount = row["condLimitCount"]
    }
}

