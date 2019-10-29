
//
//  MstItem.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct MstItem {
    let script: String
    let eventId: Int
    let eventGroupId: Int
    let id: Int
    let jpName: String
    let detail: String
    let imageId: Int
    let type: Int
    let dropPriority: Int
    let name: String
}

extension MstItem: TableRecord {
    static var databaseTableName: String { "MstItem" }
    static var databaseSelection: [SQLSelectable] = [Column("id"), Column("name")]
}

extension MstItem: FetchableRecord {
    init(row: Row) {
        script = row["script"]
        eventId = row["eventId"]
        eventGroupId = row["eventGroupId"]
        id = row["id"]
        jpName = row["jpName"]
        detail = row["detail"]
        imageId = row["imageId"]
        type = row["type"]
        dropPriority = row["dropPriority"]
        name = row["name"]
    }
}
