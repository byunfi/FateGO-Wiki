
//
//  MstSvt.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

struct MstSvt {
    let relateQuestIds: String
    let individuality: String
    let classPassive: String
    let cardIds: String
    let script: String
    let id: Int
    let baseSvtId: Int
    let jpName: String
    let ruby: String
    let battleName: String
    let classId: Int
    let type: Int
    let limitMax: Int
    let rewardLv: Int
    let friendshipId: Int
    let maxFriendshipRank: Int
    let genderType: Int
    let attri: Int
    let combineSkillId: Int
    let combineLimitId: Int
    let sellQp: Int
    let sellMana: Int
    let sellRarePri: Int
    let expType: Int
    let combineMaterialId: Int
    let cost: Int
    let battleSize: Int
    let starRate: Int
    let deathRate: Int
    let attackAttri: Int
    let illustratorId: Int
    let cvId: Int
    let collectionNo: Int
    let materialStoryPriority: Int
    let flag: Int
    let name: String
}

extension MstSvt {
    static var servants: QueryInterfaceRequest<MstSvt> {
        let id = Column("id")
        return filter(id>100000 && id<9000000 && Column("collectionNo")>0)
    }
    
    static var crafts: QueryInterfaceRequest<MstSvt> {
       return filter(Column("type")==6 && Column("collectionNo")>0)
   }
    
    static var exps: QueryInterfaceRequest<MstSvt> {
        return filter(Column("type")==3)
    }
}

extension MstSvt: TableRecord {
    static var databaseTableName: String { "MstSvt" }
    static var databaseSelection: [SQLSelectable] = [Column("id"), Column("collectionNo"), Column("name"), Column("jpName"), Column("classId")]
    
    static let svtLimit = hasOne(MstSvtLimit.self)
}

extension MstSvt: FetchableRecord {
    init(row: Row) {
        relateQuestIds = row["relateQuestIds"]
        individuality = row["individuality"]
        classPassive = row["classPassive"]
        cardIds = row["cardIds"]
        script = row["script"]
        id = row["id"]
        baseSvtId = row["baseSvtId"]
        jpName = row["jpName"]
        ruby = row["ruby"]
        battleName = row["battleName"]
        classId = row["classId"]
        type = row["type"]
        limitMax = row["limitMax"]
        rewardLv = row["rewardLv"]
        friendshipId = row["friendshipId"]
        maxFriendshipRank = row["maxFriendshipRank"]
        genderType = row["genderType"]
        attri = row["attri"]
        combineSkillId = row["combineSkillId"]
        combineLimitId = row["combineLimitId"]
        sellQp = row["sellQp"]
        sellMana = row["sellMana"]
        sellRarePri = row["sellRarePri"]
        expType = row["expType"]
        combineMaterialId = row["combineMaterialId"]
        cost = row["cost"]
        battleSize = row["battleSize"]
        starRate = row["starRate"]
        deathRate = row["deathRate"]
        attackAttri = row["attackAttri"]
        illustratorId = row["illustratorId"]
        cvId = row["cvId"]
        collectionNo = row["collectionNo"]
        materialStoryPriority = row["materialStoryPriority"]
        flag = row["flag"]
        name = row["name"]
    }
}
