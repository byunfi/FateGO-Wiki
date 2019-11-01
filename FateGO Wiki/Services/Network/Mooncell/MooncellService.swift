//
//  MooncellService.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/11/1.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import RxSwift
import enum Alamofire.AF
import protocol Alamofire.URLConvertible
import protocol Kanna.HTMLDocument
import func Kanna.HTML

class MooncellService {
    enum HTMLCacheKey: String, URLConvertible {
        func asURL() throws -> URL { URL(string: rawValue)! }
        
        case index = "https://fgo.wiki/index.php?title=%E9%A6%96%E9%A1%B5&mobileaction=toggle_view_desktop"
    }
    
    /// Requested web cache.
    private var htmlCache: [HTMLCacheKey: HTMLDocument] = [:]
    
    private let extractor = MooncellExtractor()
    
    private func htmlCache(for key: HTMLCacheKey) -> Observable<HTMLDocument> {
        if let index: Dictionary<MooncellService.HTMLCacheKey, HTMLDocument>.Index = htmlCache.index(forKey: key) {
            return Observable<HTMLDocument>.just(htmlCache[index].value)
        }
        return AF.request(key).rx.responseData()
            .map { try HTML(html: $0, encoding: .utf8) }
            .share()
    }
    
    func clearHTMLCache(for key: HTMLCacheKey? = nil) {
        if let key = key {
            htmlCache.removeValue(forKey: key)
        } else {
            htmlCache.removeAll()
        }
    }
    
    func getGameNewlyAddedContent(server: MooncellExtractor.GameServer) -> Observable<[MCNewCard] > {
        extractor.server = server
        return htmlCache(for: .index).map(extractor.extractGameNewlyAddedContent)
    }
    
    func getHomeEvents(server: MooncellExtractor.GameServer) -> Observable<[MCEvent]> {
        extractor.server = server
        return htmlCache(for: .index).map(extractor.extarctHomeEvents)
    }
    
    func getHomeSummons(server: MooncellExtractor.GameServer) -> Observable<[MCEvent]> {
        extractor.server = server
        return htmlCache(for: .index).map(extractor.extarctHomeSummons)
    }
    
    func getMasterMissions(server: MooncellExtractor.GameServer) -> Observable<MCMasterMission> {
        extractor.server = server
        return htmlCache(for: .index).map(extractor.extractMasterMissions)
    }
}
