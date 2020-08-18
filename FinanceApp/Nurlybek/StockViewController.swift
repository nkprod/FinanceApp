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
        vm.getDataRx()
        vm.closure = { result in
            self.dataSource.accept(result!)
            self.model = result
            //print(self.model?.monthlyTimeSeries)
            //self.yahooTableView.reloadData()
        }
        let logosForOptions = ["GOOGL": #imageLiteral(resourceName: "google_logo"),"AAPL": #imageLiteral(resourceName: "apple_log"), "SNE": #imageLiteral(resourceName: "sony_logo"), "AMZN": #imageLiteral(resourceName: "amazon_logo"), "MSFT": #imageLiteral(resourceName: "microsoft_logo")]
        let namesForOptions = ["GOOGL": "Google","AAPL": "Apple", "SNE": "Sony", "AMZN": "Amazon", "MSFT":"Microsoft"]
        dataSource.bind(to: self.yahooTableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StockTableViewCell
            cell.stockTextLabel?.text = namesForOptions[element.metaData.the2Symbol]
            cell.optionImage.image = logosForOptions[element.metaData.the2Symbol] as! UIImage
            return cell
        }.disposed(by: disposeBag)
        
        yahooTableView.rx.modelSelected(Stock.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.metaData.the2Symbol)")
            let st = UIStoryboard.init(name: "Finance", bundle: nil)
            let vc = st.instantiateViewController(withIdentifier: "FinanceDetailViewController") as! FinanceDetailViewController
            vc.last_refreshed = item.metaData.the3LastRefreshed
            vc.symbol = item.metaData.the2Symbol
            //vc.comapanyNameTextView.text = namesForOptions[item.metaData.the2Symbol]
            vc.stockChartData = item.monthlyTimeSeries as! [String : MonthlyTimeSery]
            self.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: disposeBag)
//        getDataRx().subscribe(onNext: { (arrPostInfo) in
//            self.dataSource.accept(arrPostInfo)
//
//        }, onError: { (error) in
//            print(error)
//        }, onCompleted: {
//
//            }).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }

//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
//    func getDataRx() -> Observable<[Stock]> {
//        return Observable<[Stock]>.create { (observer) in
//
//            let companies = ["AAPL","MSFT","AMZN","SNE","GOOGL"]
//            var results = [Stock]()
//            for company in companies {
//                URLSession.shared.dataTask(with: URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY&symbol=\(company)&apikey=BVEFVTU01YXPL88Y")!) {data,response,error in
//                    DispatchQueue.main.async{
//
//                        if error == nil {
//                            let postInfoArr = try! JSONDecoder().decode(Stock.self, from: data!)
//                            results.append(postInfoArr)
//                            observer.onNext(results)
//                        } else {
//                            observer.onError(error!)
//                        }
//                    }
//                }.resume()
//            }
//
//            let mydisposable = Disposables.create()
//            return mydisposable
//        }
//    }
    


}

