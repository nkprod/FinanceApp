//
//  ViewController.swift
//  Weather
//
//  Created by Milan Chalishajarwala on 8/14/20.
//  Copyright © 2020 Milan Chalishajarwala. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    let uilabel = UILabel.self
    let disposeBag = DisposeBag()
    let viewModel = WeatherViewModel()
    var currentLocation: CLLocation?
    var locationManager = CLLocationManager()
   // var cm: CurrentWeatherModel?
    @IBOutlet weak var citySearch: UISearchBar!
    @IBOutlet weak var regionName: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var Temperature: UILabel!

    @IBOutlet weak var lastUpdated: UILabel!
    
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var localTime: UILabel!
    
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var precipitationLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var visibiltyLabel: UILabel!
    
    @IBOutlet weak var gustSpeedLabel: UILabel!
    
    @IBOutlet weak var myLocation: UIButton!
   
    
    let gifview = UIImageView()

    
    @IBAction func myLocationAction(_ sender: UIButton) {
        requestWeatherForLocation()
    }
    
    @IBOutlet weak var gifOutlet: UIImageView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        gifOutlet.alpha = 0.5
        gifOutlet.loadGif(name: "giphy")
        gifOutlet.layer.zPosition = -1
        myLocation.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        myLocation.setTitle("My Location", for: .normal)
        myLocation.translatesAutoresizingMaskIntoConstraints = true
        myLocation.frame.size.width = 100
        citySearch.delegate = self
        citySearch.placeholder = "Enter City Name. Ex: London"
        citySearch.showsCancelButton = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataReceived"), object: nil, queue: .main) { (notification) in

                let data = notification.userInfo!["CurrentWeatherData"] as! CurrentWeatherModel
                
                DispatchQueue.main.async {
                    self.regionName.text = "\(data.location.name), \(data.location.region)"
                    self.weatherType.text = data.current.condition.text
                     let strIndex = data.location.localtime.index( data.location.localtime.startIndex, offsetBy: 11)
                    let strIndexEnd = data.location.localtime.index( data.location.localtime.startIndex, offsetBy: 12)
                    let currentTime =  data.location.localtime[strIndex...]
                    let int = Int(data.location.localtime[strIndex...strIndexEnd])
                   
                    self.localTime.text = "Local Time \(currentTime)"
                    self.Temperature.text = "\(Int(data.current.temp_f))°F"
                    self.feelsLike.text = "\(Int(data.current.feelslike_f))°F"
                    let strIndexForUpdated = data.current.last_updated.index( data.current.last_updated.startIndex, offsetBy: 11)
                    let lastUpdatedTime =  data.current.last_updated[strIndex...]
                    self.lastUpdated.text = "Last Updated at \(lastUpdatedTime)"
                    self.windSpeedLabel.text = "\(data.current.wind_mph) Mph"
                    self.windDirectionLabel.text = "\(data.current.wind_degree)° \(data.current.wind_dir)"
                    self.precipitationLabel.text = "\(data.current.precip_in) In"
                    self.humidityLabel.text = "\(data.current.humidity) %"
                    self.visibiltyLabel.text = "\(Int(data.current.vis_km/1.6)) Miles"
                    self.gustSpeedLabel.text = "\(data.current.gust_mph) Mph"
                }

                    
        
            }
        //activityIndicator.isHidden = true


    }
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        citySearch.searchTextField.resignFirstResponder()
       }
    
    
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       

        setUpLocation()

    }
    func setUpLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty && currentLocation == nil{
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    func requestWeatherForLocation(){
        guard let currentLocation = currentLocation else {return}
        let lat  = String(currentLocation.coordinate.latitude)
        let long = String(currentLocation.coordinate.longitude)
        let withUrlString = "https://api.weatherapi.com/v1/current.json?key=02051ce839bb4e3997a190509201408&q=\(lat),\(long)"
        self.viewModel.callApiFromViewModel(withUrlString: withUrlString)
        

    }
    
    func requestWeatherForLocationUsingName(name: String){
           let withUrlString = "https://api.weatherapi.com/v1/current.json?key=02051ce839bb4e3997a190509201408&q=\(name)"
           self.viewModel.callApiFromViewModel(withUrlString: withUrlString)

       }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestWeatherForLocationUsingName(name: searchBar.text!)
    }

    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        requestWeatherForLocationUsingName(name: searchBar.text!)
        citySearch.searchTextField.resignFirstResponder()
        citySearch.text = ""
    }
    
}

