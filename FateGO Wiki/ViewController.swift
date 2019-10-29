//
//  ViewController.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/10/29.
//  Copyright © 2019 白云飞. All rights reserved.
//

import UIKit
import GRDB

class ViewController: UIViewController {
    
    private let dbQueue: DatabaseQueue = {
        var config = Configuration()
        config.readonly = true
        config.trace = { print($0) }
        let path = Bundle.main.path(forResource: "md", ofType: "sqlite")!
        let queue = try! DatabaseQueue(path: path, configuration: config)
        return queue
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        let request = MstSkillDetail.including(required: MstSkillDetail.skill.select(Column("name")))//.filter(Column("id")==5550)
        
//        let n = request.filter(Column("name")=="领袖气质 A")
        let n = MstSvtSkill.including(optional: MstSvtSkill.skill
            .including(optional: MstSkill.detail)
            .including(optional: MstSkill.lv.filter(Column("lv")==1))
        ).filter(Column("svtId")==100800)
            .order(Column("num"), Column("strengthStatus"), Column("flag"))
        dbQueue.read { db in
            
//            let n = MstSvt.servants.including(required: MstSvt.svtLimit.select(Column("rarity"))).filter(Column("id")==100800)
            let r = try! Row.fetchAll(db, n)
//            let a = SkillInfo(row: r.unadapted)
            print(r.map { FGOSkill(row: $0.unadapted) })
        }
        
    }

}

struct SkillInfo: Decodable {
    let name: String
    let detail: [String]
    let value: [[String]]
}


extension SkillInfo: TableRecord {
    static var databaseSelection: [SQLSelectable] = [Column("name"), Column("detail"), Column("value")]
}

extension SkillInfo: FetchableRecord {
//    init(row: Row) {
//        let r: LazyMapCollection<Row, String> = row.columnNames
////        for a in r.enumerated() {
////            print(a)
////        }
//        var b = r.makeIterator()
//        var d = b.base
//
//        MstSkill(row: row)
//        while let c = d.next() {
//            print(c)
//        }
//        name = ""
//        detail = []
//    }
}
