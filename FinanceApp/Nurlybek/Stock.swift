//
//  Stock.swift
//  FinanceApp
//
//  Created by Nulrybek Karshyga on 8/7/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Stock: Codable {
    let metaData: MetaData
    let monthlyTimeSeries: [String: MonthlyTimeSery]

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case monthlyTimeSeries = "Monthly Time Series"
    }
}

// MARK: - MetaData
struct MetaData: Codable {
    let the1Information, the2Symbol, the3LastRefreshed, the4TimeZone: String

    enum CodingKeys: String, CodingKey {
        case the1Information = "1. Information"
        case the2Symbol = "2. Symbol"
        case the3LastRefreshed = "3. Last Refreshed"
        case the4TimeZone = "4. Time Zone"
    }
}

// MARK: - MonthlyTimeSery
struct MonthlyTimeSery: Codable {
    let the1Open, the2High, the3Low, the4Close: String
    let the5Volume: String

    enum CodingKeys: String, CodingKey {
        case the1Open = "1. open"
        case the2High = "2. high"
        case the3Low = "3. low"
        case the4Close = "4. close"
        case the5Volume = "5. volume"
    }
}


struct MonthlyPrice{
    let date: String
    let open: Double
    let high: Double
    let low: Double
    let close: Double
    let volume: Int
}
