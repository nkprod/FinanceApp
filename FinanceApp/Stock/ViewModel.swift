//
//  ViewModel.swift
//  FinanceApp
//
//  Created by Nulrybek Karshyga on 8/7/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    var closure: ((_: [Stock]?)->())?
    
    var apiHandler = APIHandler.init()
    let disposeBag = DisposeBag()
    var result = [Stock]()
    var error: Error?
    var response: URLResponse?
    
    func getDataRx() {

        apiHandler.getDataRx().subscribe(onNext: { (arrPostInfo) in
            let result = arrPostInfo
            self.closure?(result)
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            
            }).disposed(by: disposeBag)
        
//        apiHandler.closure = {(data, response, error) in
//            if error == nil {
//                let postInfoArr = try! JSONDecoder().decode(Stock.self, from: data!)
//                self.result.append(postInfoArr)
//                
//            } else {
////                observer.onError(error!)
//            }
//            self.response = response
//            self.closure?(self.result)
//        }
    }
//    func getCount() -> Int{
//        return result.count
//    }
    
//    func getObject() -> Stock?{
//        return result
//    }
}
