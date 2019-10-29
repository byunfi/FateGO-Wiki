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
    
    private var dbQueue: DatabaseQueue!
    
    func getServants(_ predicate: SQLExpressible, orderings: [SQLOrderingTerm]) {
        MstSvt.servants.including(required: MstSvt.svtLimit)
    }
    
    func getServantSkill(_ svtId: Int) {
        let skill = MstSvtSkill.skill
            .including(optional: MstSkill.detail)
            .including(optional: MstSkill.lv.filter(Column("lv")==1))
        let request = MstSvtSkill.including(optional: skill).filter(Column("svtId")==svtId)
            .order(Column("num"), Column("strengthStatus"), Column("flag"))
        
    }
}
