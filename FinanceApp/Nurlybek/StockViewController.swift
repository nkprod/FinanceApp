//
//  ViewController.swift
//  FinanceApp
//
//  Created by Nulrybek Karshyga on 8/7/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class StockViewController: UIViewController,UITableViewDelegate {
    let dataSource: BehaviorRelay<[Stock]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    var vm = ViewModel.init()
    var model: [Stock]?
    var arrangeDate: [[String]]?
    @IBOutlet weak var yahooTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yahooTableView.delegate = self
//        yahooTableView.dataSource = self
//        vm.getDataRx()
//        vm.closure = { result in
//            observer.onNext(results)
//            //print(self.model?.monthlyTimeSeries)
//            //self.yahooTableView.reloadData()
//        }
        dataSource.bind(to: self.yahooTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StockTableViewCell
            cell.stockTextLabel?.text = element.metaData.the2Symbol
            cell.stockChartData = element.monthlyTimeSeries
            return cell
        }.disposed(by: disposeBag)
        

        getDataRx().subscribe(onNext: { (arrPostInfo) in
            self.dataSource.accept(arrPostInfo)
            
        }, onError: { (error) in
            print(error)
        }, onCompleted: {
            
            }).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StockTableViewCell
//        cell.stockTextLabel?.text = model?.metaData.the2Symbol
//        if let chartData = self.model?.monthlyTimeSeries {
//            cell.stockChartData = chartData
//            //print(chartData)
//        }
//        return cell
//    }
//
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func getDataRx() -> Observable<[Stock]> {
        return Observable<[Stock]>.create { (observer) in
            
            let companies = ["AAPL","MSFT","AMZN","SNE","GOOGL",[]]
            var results = [Stock]()
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
    


}

