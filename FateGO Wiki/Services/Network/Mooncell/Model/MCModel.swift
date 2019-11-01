//
//  MCCard.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/11/1.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation

struct MCCard {
    let name: String
    let refernceLink: String?
    let imageLink: String
}

enum MCNewCard {
    case servant([MCCard])
    case craft([MCCard])
    case commandCode([MCCard])
    case enhancement([MCCard])
}

enum MCEvent {
    case currentMain([MCCard])
    case current([MCCard])
    case comming([MCCard])
    case future([MCCard])
}

struct MCMasterMission {
    let openDate: Date?
    let closeDate: Date?
    let missions: [String]
}
