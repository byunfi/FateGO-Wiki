
//
//  MstSkillDetail.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct MstSkillDetail {
    let id: Int
    let detail: [String]
    let value: [[String]]
}

extension MstSkillDetail: TableRecord {
    static var databaseTableName: String { "MstSkillDetail" }
}

extension MstSkillDetail: FetchableRecord {
    init(row: Row) {
        id = row["id"]
        detail = row["detail"]
        value = row["value"]
    }
}
