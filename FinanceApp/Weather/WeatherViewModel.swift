//
//  ViewModel.swift
//  Weather
//
//  Created by Milan Chalishajarwala on 8/14/20.
//  Copyright © 2020 Milan Chalishajarwala. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
var int_location: Location = Location(name: "", region: "", country: "", lat: 0.0, lon: 0.0, tz_id: "", localtime_epoch: 0, localtime: "")
var int_condition: condition = condition(text: "", icon: "", code: 0)

var int_current: current = current(last_updated_epoch: 0, last_updated: "", temp_c: 0.0, temp_f: 0.0, is_day: 0, condition: int_condition, wind_mph: 0.0, wind_dir: "", wind_degree: 0, wind_kph: 0.0, pressure_mb: 0.0, pressure_in: 0.0, precip_mm: 0.0, precip_in: 0.0, humidity: 0, cloud: 0, feelslike_c: 0.0, feelslike_f: 0.0, vis_km: 0.0, uv: 0.0, gust_mph: 0.0, gust_kph: 0.0)

var int_currentweathermodel: CurrentWeatherModel = CurrentWeatherModel(location: int_location, current: int_current )

class WeatherViewModel{
    var results: CurrentWeatherModel?
    let dataSource: BehaviorRelay<CurrentWeatherModel> = BehaviorRelay(value: int_currentweathermodel)
      var error: Error?
      let disposeBag = DisposeBag()

    func callApiFromViewModel(withUrlString: String){
        
          let disposable = APIHandler.init().weatherHandler(withUrlString: withUrlString).subscribe(onNext: { (data) in
            let jsonDecoderObj = JSONDecoder.init()
            var model: CurrentWeatherModel?
              do{
                model = try? jsonDecoderObj.decode(CurrentWeatherModel.self, from: data!)
                if model == nil{
                    return
                }else{
                self.dataSource.accept(model!)
                }
              }catch{
                  self.error = error
              }
            NotificationCenter.default.post(name: Notification.Name(rawValue: "dataReceived"), object: nil, userInfo: ["CurrentWeatherData": model!])
          }, onError: { (error) in
              self.error = error
          }, onCompleted: {
              
          }) {
          }
          disposable.disposed(by: disposeBag)
      }
    
   
}

