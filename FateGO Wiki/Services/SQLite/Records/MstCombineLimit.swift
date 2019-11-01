//
//  MstCombineLimit.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct MstCombineLimit {
    let itemIds: [Int]
    let itemNums: [Int]
    let id: Int
    let svtLimit: Int
    let qp: Int
}

extension MstCombineLimit: TableRecord {
    static var databaseTableName: String { "MstCombineLimit" }
}

extension MstCombineLimit: FetchableRecord {
    init(row: Row) {
        itemIds = row["itemIds"]
        itemNums = row["itemNums"]
        id = row["id"]
        svtLimit = row["svtLimit"]
        qp = row["qp"]
    }
}
