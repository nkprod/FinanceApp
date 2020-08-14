//
//  StockTableViewCell.swift
//  FinanceApp
//
//  Created by Nulrybek Karshyga on 8/14/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import UIKit
import Charts
import TinyConstraints


class StockTableViewCell: UITableViewCell {

    @IBOutlet weak var stockTextLabel: UILabel!
    @IBOutlet weak var chartDataLabel: UILabel!
    var arrangeDate = [[String]]()
    let dateFormatter = DateFormatter()
    
    let lineChartView: LineChartView = {
        let chartView = LineChartView()
        //chartView.backgroundColor = .systemBlue
        return chartView
    }()
    var stockChartData = [String: MonthlyTimeSery]() {
        didSet{

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
    //            print(sortedArray)
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
            
        }
    }



    
    override func awakeFromNib() {
        super.awakeFromNib()

        //chartDataLabel.text = "\(stockChartData.keys)"
//        let sortedArray = self.arrangeDate?.sorted(by: {left, right in
//            let leftDate = self.dateFormater.date(from: left[0])
//            let rightDate = self.dateFormater.date(from: right[0])
//            return leftDate!.compare(rightDate!) == .orderedAscending
//        })
//        var finalArray = [MonthlyPrice]()
//        for var data in sortedArray!{
//            finalArray.append(MonthlyPrice(date: data[0], open: Double(data[1])!, high: Double(data[2])!, low: Double(data[3])!, close: Double(data[4])!, volume: Int(data[5])!))
//        }

        
        
        addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.widthToSuperview()
        lineChartView.height(200)
        
        //print(stockChartData)
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
