//
//  MstSvtLimit.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct MstSvtLimit {
    let svtId: Int
    let limitCount: Int
    let rarity: Int
    let lvMax: Int
    let hpBase: Int
    let hpMax: Int
    let atkBase: Int
    let atkMax: Int
    let criticalWeight: Int
    let power: Int
    let defense: Int
    let agility: Int
    let magic: Int
    let luck: Int
    let treasureDevice: Int
    let policy: Int
    let personality: Int
    let deity: Int
}

extension MstSvtLimit: TableRecord {
    static var databaseTableName: String { "MstSvtLimit" }
}

extension MstSvtLimit: FetchableRecord {
    init(row: Row) {
        svtId = row["svtId"]
        limitCount = row["limitCount"]
        rarity = row["rarity"]
        lvMax = row["lvMax"]
        hpBase = row["hpBase"]
        hpMax = row["hpMax"]
        atkBase = row["atkBase"]
        atkMax = row["atkMax"]
        criticalWeight = row["criticalWeight"]
        power = row["power"]
        defense = row["defense"]
        agility = row["agility"]
        magic = row["magic"]
        luck = row["luck"]
        treasureDevice = row["treasureDevice"]
        policy = row["policy"]
        personality = row["personality"]
        deity = row["deity"]
    }
}
