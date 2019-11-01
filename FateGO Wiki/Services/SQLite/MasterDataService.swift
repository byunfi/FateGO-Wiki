//
//  MasterDataService.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import GRDB

/// Provide data from game unpacking.
class MasterDataService {
    
    private var dbQueue: DatabaseQueue! = {
        var config = Configuration()
        config.readonly = true
        config.trace = { print($0) }
        let path = Bundle.main.path(forResource: "md", ofType: "sqlite")!
        let queue = try! DatabaseQueue(path: path, configuration: config)
        return queue
    }()
    
    func getServants(_ predicate: SQLExpressible, orderings: [SQLOrderingTerm]) throws -> [FGOServantLite] {
        //TODO:- 分离mstSvt和mstSvtLimit条件
        let limitRequest = MstSvt.svtLimit.select(Column("rarity"))
            .filter(Column("limitCount")==0)
        let request = MstSvt.servants.including(optional: limitRequest)
            .filter(predicate).order(orderings)
        return try dbQueue.read { db in
            let res = try Row.fetchCursor(db, request)
            return try Array(res.map { FGOServantLite(row: $0.unadapted) })
        }
    }
    
    func getServantSkills(_ svtId: Int) throws -> [FGOSkill] {
        let skillRequest = MstSvtSkill.skill
            .including(optional: MstSkill.detail)
            .including(optional: MstSkill.lv.filter(Column("lv")==1))
        let request = MstSvtSkill.including(optional: skillRequest).filter(Column("svtId")==svtId)
            .order(Column("num"), Column("strengthStatus"), Column("flag"))
        return try dbQueue.read { db in
            let res = try Row.fetchCursor(db, request)
            return try Array(res.map { FGOSkill(row: $0.unadapted) })
        }
    }
    
    func getClassSkills(_ svtId: Int) throws -> [FGOClassSkill] {
        return try dbQueue.read { db in
            let classPassiveRequest = MstSvt.select(Column("classPassive"))
                .filter(Column("id")==svtId)
            let classPassives = try [Int].fetchOne(db, classPassiveRequest)!
            let request = MstSkill.select(Column("id"), Column("name"), Column("iconId"))
                .filter(classPassives.contains(Column("id")))
                .including(optional: MstSkill.detail)
            let res = try Row.fetchCursor(db, request)
            return try Array(res.map { FGOClassSkill(row: $0.unadapted) })
        }
    }
    
    func getServantSkillEnhancementMaterials(_ svtId: Int) throws {
        try dbQueue.read { db in
            let skillLvs = try MstSkillLv.filter(Column("id")==svtId).fetchAll(db)
        }
    }
}
