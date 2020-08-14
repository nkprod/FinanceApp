//
//  APIHaandler.swift
//  
//
//  Created by Nulrybek Karshyga on 8/14/20.
//

import Foundation
import RxSwift
import RxCocoa

class APIHandler {
    var closure: ((Data?, URLResponse?, Error?)->())?
    func getDataRx() -> Observable<[Stock]> {
        return Observable<[Stock]>.create { (observer) in
            
            let companies = ["AAPL","MSFT","AMZN","SNE","GOOGL"]
            for company in companies {
                URLSession.shared.dataTask(with: URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=\(company)&apikey=BVEFVTU01YXPL88Y")!) {data,response,error in
                    DispatchQueue.main.async{
                        self.closure?(data,response,error)
                    }
                }.resume()
            }
            
            let mydisposable = Disposables.create()
            return mydisposable
        }
    }
}
