//
//  FGOServantLite.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/11/1.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct FGOServantLite {
    let id: Int
    let collectionNo: Int
    let name: String?
    let jpName: String
    let classId: Int
    let rarity: Int
}

extension FGOServantLite: FetchableRecord {
    init(row: Row) {
        id = row["id"]
        collectionNo = row["collectionNo"]
        name = row["name"]
        jpName = row["jpName"]
        classId = row["classId"]
        rarity = row["rarity"]
    }
}
