//
//  ViewModel.swift
//  Spotify_Embeded
//
//  Created by Chen Chen on 8/15/20.
//  Copyright © 2020 chen chen. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
class MusicViewModel {
    let datasource: BehaviorRelay<[Item]> = BehaviorRelay(value: [])
    let disposalBag = DisposeBag()
    func callAPI(urlString: String) {
        APIHandler.init().musicHandler(urlString: urlString).subscribe(onNext: ({data in
            let model = try! JSONDecoder.init().decode([Item].self, from: data!)
            self.datasource.accept(model)
        }), onError: ({ error in
            
        }), onCompleted: ({
            
        }), onDisposed: ({
            
        }))
    }
    
}
