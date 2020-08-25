//
//  CurrentWeatherModel.swift
//  Weather
//
//  Created by Milan Chalishajarwala on 8/14/20.
//  Copyright © 2020 Milan Chalishajarwala. All rights reserved.
//

import Foundation
import UIKit


struct CurrentWeatherModel: Codable{
    let location: Location
    let current: current
}

struct Location: Codable{
    let name:String
    let region:String
    let country:String
    let lat: Double
    let lon: Double
    let tz_id:String
    let localtime_epoch:Int
    let localtime:String
}

struct current: Codable {
    var last_updated_epoch:Int
    var last_updated: String
    var temp_c: Double
    var temp_f: Double
    var is_day: Int
    var condition: condition
    var wind_mph:Double
    var wind_dir:String
    var wind_degree:Int
    var wind_kph:Double
    var pressure_mb:Double
    var pressure_in:Double
    var precip_mm:Double
    var precip_in:Double
    var humidity:Int
    var cloud:Int
    var feelslike_c:Double
    var feelslike_f:Double
    var vis_km:Double
    var uv:Double
    var gust_mph:Double
    var gust_kph:Double
}

struct condition: Codable{
    var text: String
    var icon: String
    var code: Int
}
