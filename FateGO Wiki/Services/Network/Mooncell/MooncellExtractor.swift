//
//  MooncellExtractor.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/11/1.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import Kanna

private let missionPredicationDateFormattor: DateFormatter = {
    let df = DateFormatter()
    df.dateFormat = "yyyy年M月d日"
    df.timeZone = TimeZone(secondsFromGMT: 8)
    df.locale = Locale(identifier: "zh_CN")
    return df
}()

enum MooncellExtractorError: Error {
    case subtitleNotMatch
}

class MooncellExtractor {
    enum GameServer: String {
        case cn // bilibili server
        case jp // jp server
        case next
    }
    
    enum CardType: String, CustomStringConvertible {
        case homeEvents = "home-events"
        case homeSummons = "home-summons"
        case newCards = "new-cards"
        case weeklyMission = "weekly-mission"
        
        var description: String {
            return rawValue
        }
    }
    
    var server: GameServer = .cn
    
    func extractGameNewlyAddedContent(html: HTMLDocument) throws -> [MCNewCard] {
        try extractCards(html: html, cardType: .newCards) { subtitle, cards in
            switch subtitle {
                case "从者强化":
                    return .enhancement(cards)
                case "从者":
                    return .servant(cards)
                case "概念礼装":
                    return .craft(cards)
                case "指令纹章":
                    return .commandCode(cards)
                default:
                    throw MooncellExtractorError.subtitleNotMatch
            }
        }
    }
    
    func extarctHomeEvents(html: HTMLDocument) throws -> [MCEvent] {
        try extractCards(html: html, cardType: .homeEvents) { subtitle, cards in
            switch subtitle {
            case let x where x.starts(with: "当前主要"):
                return .currentMain(cards)
            case let x where x.starts(with: "当前"):
                return .current(cards)
            case let x where x.starts(with: "即将开放"):
                return .comming(cards)
            case let x where x.starts(with: "未来开放"):
                return .future(cards)
            default:
                throw MooncellExtractorError.subtitleNotMatch
            }
        }
    }
    
    func extarctHomeSummons(html: HTMLDocument) throws -> [MCEvent] {
        try extractCards(html: html, cardType: .homeSummons) { subtitle, cards in
            switch subtitle {
            case let x where x.starts(with: "当前主要"):
                return .currentMain(cards)
            case let x where x.starts(with: "当前"):
                return .current(cards)
            case let x where x.starts(with: "即将开放"):
                return .comming(cards)
            case let x where x.starts(with: "未来开放"):
                return .future(cards)
            default:
                throw MooncellExtractorError.subtitleNotMatch
            }
        }
    }
    
    func extractNextCNMasterMissions(html: HTMLDocument) -> MCMasterMission {
        let oldServer = server
        server = .next
        let mm = extractMasterMissions(html: html)
        server = oldServer
        return mm
    }
    
    func extractMasterMissions(html: HTMLDocument) -> MCMasterMission {
        let xpath = "//*[@id=\"\(CardType.weeklyMission)-container-\(server)\"]/p"
        var openDate: Date?
        var closeDate: Date?
        var missions: [String] = []
        for p in html.xpath(xpath) {
            if p.className == "weekly-mission-date", let dateText = p.text {
                let dateTexts = dateText.split(separator: "~")
                if dateTexts.count != 2 { continue }
                let df = missionPredicationDateFormattor
                let open = String(dateTexts[0])
                openDate = df.date(from: open)
                let close = String(dateTexts[1])
                if close.count > 8 {
                    closeDate = df.date(from: close)
                } else {
                    if let year = Int(open[0..<4]), let d = df.date(from: "\(year)年\(close)") {
                        if let openDate = openDate, d < openDate {
                            closeDate = df.date(from: "\(year+1)年\(close)")
                        } else {
                            closeDate = d
                        }
                    }
                }
                continue
            }
            if p.className == "weekly-mission-desc",
                let missionTextRaw = p.text {
                var res = missionTextRaw.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: false)
                res.remove(at: 0)
                missions.append(res.joined())
            }
        }
        let mm = MCMasterMission(openDate: openDate, closeDate: closeDate, missions: missions)
        return mm
    }
    
    /// Extract card content from html.
    ///
    /// - parameter html: `Mooncell` index web page.
    /// - parameter cardType: The kind of card in page.
    /// - parameter package: Package extracted files into models.
    private func extractCards<T>(html: HTMLDocument, cardType: CardType, package: (_ subtitle: String, _ cards: [MCCard]) throws -> T) throws -> [T] {
        let xpath = "//*[@id=\"\(cardType)-container-\(server)\"]/div"
        let subtitleXPath = "self::div[@class=\"\(cardType)-subtitle\"]"
        var currentSubtitle = ""
        let domain = "https://fgo.wiki"
        var items: [T] = []
        for div in html.xpath(xpath) {
            if let subtitle = div.xpath(subtitleXPath).first?.text {
                currentSubtitle = subtitle
                continue
            }
            
            if let className = div.className, className.starts(with: cardType.rawValue) {
                let aXpath = cardType == .homeEvents ? #"span[@class="nomobile"]/a"# : "a"
                let aObject = div.xpath(aXpath)
                if aObject.count == 0 {
                    currentSubtitle = ""
                    continue
                }
                let cards = aObject.map { a -> MCCard in
                    let title = a.xpath("@title").first?.text ?? ""
                    let href = a.xpath("@href").first?.text.map { domain + $0 }
                    let imageLink = a.xpath("img/@data-src").first?.text.map { domain + $0 }
                    return MCCard(name: title, refernceLink: href, imageLink: imageLink!)
                }
                let item = try package(currentSubtitle, cards)
                items.append(item)
            }
        }
        return items
    }
}
