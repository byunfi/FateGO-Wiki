//
//  Alamofire+rx.swift
//  FateGO Wiki
//
//  Created by 白云飞 on 2019/11/1.
//  Copyright © 2019 白云飞. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension Alamofire.DataRequest: ReactiveCompatible {}

extension Reactive where Base: Alamofire.DataRequest {
    func responseData() -> Observable<Data> {
        return Observable<Data>.create { [weak base] observer in
            base?.responseData { resp in
                switch resp.result {
                    case .success(let data):
                        observer.onNext(data)
                    case .failure(let e):
                        observer.onError(e)
                }
            }
            return Disposables.create()
        }
    }
}
