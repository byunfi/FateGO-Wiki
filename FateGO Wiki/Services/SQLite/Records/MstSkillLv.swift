
//
//  MstSkillLv.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct MstSkillLv {
    let funcId: String
    let svals: String
    let script: String
    let skillId: Int
    let lv: Int
    let chargeTurn: Int
    let skillDetailId: Int
}

extension MstSkillLv: TableRecord {
    static var databaseTableName: String { "MstSkillLv" }
    static var databaseSelection: [SQLSelectable] = [Column("chargeTurn")]
}

extension MstSkillLv: FetchableRecord {
    init(row: Row) {
        funcId = row["funcId"]
        svals = row["svals"]
        script = row["script"]
        skillId = row["skillId"]
        lv = row["lv"]
        chargeTurn = row["chargeTurn"]
        skillDetailId = row["skillDetailId"]
    }
}
