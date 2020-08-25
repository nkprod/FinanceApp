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
            var results = [Stock]()
            let companies = ["AAPL","MSFT","AMZN","SNE","GOOGL"]
            for company in companies {
                
                URLSession.shared.dataTask(with: URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=\(company)&apikey=BVEFVTU01YXPL88Y")!) {data,response,error in
                    
                    DispatchQueue.main.async{
                        
                        if error == nil {
                            let postInfoArr = try! JSONDecoder().decode(Stock.self, from: data!)
                            results.append(postInfoArr)
                            observer.onNext(results)
                        } else {
                            observer.onError(error!)
                        }
                    }
                }.resume()
            }
            
            let mydisposable = Disposables.create()
            return mydisposable
        }
    }
    
    let token = "BQCq8CWj6-1OXkG3YX2LZ_LwhAjcVKx7cFYM1Oflqy4x50cEk5_2kCFqyx6Lo0PpOU7_fVhMyMeqrQbaNETUGcdWSFJK1_jpgypEf5gE3rNeCstfr1shX-sBtQ_q9KhTSz_rvObxLTV6EIATSbZaTMcVSllruIE"
    
    func MusicHandle(urlString: String)->Observable<Data?> {
        Observable<Data?>.create{(observer) in
            var semaphore = DispatchSemaphore (value: 0)
            var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
            request.addValue("Bearer \(self.token)", forHTTPHeaderField: "Authorization")
            request.addValue("_ga=GA1.2.1761341872.1597555175; _gid=GA1.2.1827983463.1597555175; sp_dc=AQBen9sngVKtiKjL0WQGSlOetPGsLbe-xG0aziRw1MqZK_9CZ_ntSyobFQiTF1UJK92YgmtHVSXeU5pqq3pQlsjf1-hWvampZ_OzCG3_9w; sp_key=161d9caa-4c7d-48c2-b0a4-a69774f6a7d6", forHTTPHeaderField: "Cookie")
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                if error != nil {
                    observer.onError(error!)
                }
                else {
                    do {
                        let model = try JSONDecoder.init().decode(TrackInfo.self, from: data!)
                        let newData = try!JSONEncoder.init().encode(model.tracks.items)
                        observer.onNext(newData)
                    }
                    catch {
                    }
                    
                    
                }
                semaphore.signal()
            }
            task.resume()
            semaphore.wait()
            let disposal = Disposables.create()
            return disposal
        }
    }
    
    public func callAPIFromApiHandler(withUrlString : String)
        -> Observable<Data?> {
            
            Observable<Data?>.create { observer  in
                
                URLSession.shared.dataTask(with: URL(string: withUrlString)!) { (data, response, error) in
                    print(data)
                    print(response)
                    observer.onNext(data)
                    if error != nil {
                        observer.onError(error!)
                    }
                    observer.onCompleted()
                    
                }.resume()
                let disposable = Disposables.create()
                return disposable
                
            }
    }
}
