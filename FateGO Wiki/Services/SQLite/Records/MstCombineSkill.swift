//
//  MstCombineSkill.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct MstCombineSkill {
    let itemIds: [Int]
    let itemNums: [Int]
    let id: Int
    let skillLv: Int
    let qp: Int
}

extension MstCombineSkill: TableRecord {
    static var databaseTableName: String { "MstCombineSkill" }
}

extension MstCombineSkill: FetchableRecord {
    init(row: Row) {
        itemIds = row["itemIds"]
        itemNums = row["itemNums"]
        id = row["id"]
        skillLv = row["skillLv"]
        qp = row["qp"]
    }
}
