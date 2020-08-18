//
//  FinanceDetailViewController.swift
//  FinanceApp
//
//  Created by Nulrybek Karshyga on 8/14/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import UIKit
import Charts
import RxSwift
import TinyConstraints

class FinanceDetailViewController: UIViewController {
    
    @IBOutlet weak var stockTextLabel: UILabel!
    @IBOutlet weak var last_refreshedTextLabel: UILabel!
    @IBOutlet weak var highTextLabel: UILabel!
    @IBOutlet weak var comapanyNameTextView: UILabel!
    
    @IBOutlet weak var volumeTextLabel: UILabel!
    @IBOutlet weak var closeTextLabel: UILabel!
    @IBOutlet weak var lowTextLabel: UILabel!
    @IBOutlet weak var openTextLabel: UILabel!
    var arrangeDate = [[String]]()
    let dateFormatter = DateFormatter()

    let lineChartView: LineChartView = {
        let chartView = LineChartView()
        //chartView.backgroundColor = .systemBlue
        return chartView
    }()
    var symbol: String?
    var last_refreshed: String?

    var stockChartData = [String: MonthlyTimeSery]()
    override func viewDidLoad() {
        super.viewDidLoad()
        stockTextLabel.text = symbol
        last_refreshedTextLabel.text = last_refreshed
        

        
        DispatchQueue.global(qos: .userInitiated).async{
            for (key, value) in self.stockChartData{
                let open = value.the1Open
                let high = value.the2High
                let low = value.the3Low
                let close = value.the4Close
                let volume = value.the5Volume
                self.arrangeDate.append([key, open, high, low, close, volume])
            }
            let sortedArray = self.arrangeDate.sorted(by: {left, right in
                
                let leftDate = SingletonDateFomratter.shared.dateFormatter?.date(from: left[0])
                let rightDate = SingletonDateFomratter.shared.dateFormatter?.date(from: right[0])
                return leftDate?.compare(rightDate!) == .orderedAscending
            })
            var dataEntries: [ChartDataEntry] = []
            for i in 0..<sortedArray.count {
                let dataEntry = ChartDataEntry(x: Double(i) , y: (sortedArray[i][4] as NSString).doubleValue)
                dataEntries.append(dataEntry)
            }
            //print(sortedArray.last)
            DispatchQueue.main.async {
                if let last_updated_stat = sortedArray.last {
                    self.openTextLabel.text = String(format: "%.2f", (last_updated_stat[1] as NSString).doubleValue)
                    self.highTextLabel.text = String(format: "%.2f", (last_updated_stat[2] as NSString).doubleValue)
                    self.lowTextLabel.text = String(format: "%.2f", (last_updated_stat[3] as NSString).doubleValue)
                    self.closeTextLabel.text = String(format: "%.2f", (last_updated_stat[4] as NSString).doubleValue)
                    self.volumeTextLabel.text = String(format: "%.2f", (last_updated_stat[5] as NSString).doubleValue)
                }
            }

            let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: "Price")
            lineChartDataSet.circleColors = [UIColor.black]
            lineChartDataSet.circleRadius = 0.1
            lineChartDataSet.drawValuesEnabled = false
            lineChartDataSet.drawFilledEnabled = true
            lineChartDataSet.colors = [UIColor.black]
            let lineChartData = LineChartData(dataSet: lineChartDataSet)
            DispatchQueue.main.async{
                self.lineChartView.data = lineChartData
            }
        }
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.widthToSuperview()
        lineChartView.height(300)
        // Do any additional setup after loading the view.
    }
    
}


class SingletonDateFomratter {
    static let shared = SingletonDateFomratter()
    var dateFormatter: DateFormatter?
    private init() {
        dateFormatter = DateFormatter()
        dateFormatter?.dateFormat = "yyyy-mm-dd"
    }
}
