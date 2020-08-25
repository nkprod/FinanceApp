//
//  MainTabBarViewController.swift
//  FinanceApp
//
//  Created by Nulrybek Karshyga on 8/18/20.
//  Copyright © 2020 Nulrybek Karshyga. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        // first tab
        let st1 = UIStoryboard(name: "Finance", bundle: nil)
        let tab1 = st1.instantiateViewController(withIdentifier: "FinanceNavigationController") as! FinanceNavigationController
        let icon1 = UITabBarItem(title: "", image: UIImage(named: "stock.png"), selectedImage: UIImage(named: "stock.png"))
        // second tab
        let st2 = UIStoryboard(name: "Music", bundle: nil)
        let tab2 = st2.instantiateViewController(withIdentifier: "MusicSearchViewController") as! MusicSearchViewController
        let icon2 = UITabBarItem(title: "", image: UIImage(named: "music.png"), selectedImage: UIImage(named: "music.png"))
        // third tab
        let st3 = UIStoryboard(name: "Movie", bundle: nil)
        let tab3 = st3.instantiateViewController(withIdentifier: "MovieNavigationController") as! MovieNavigationController
        let icon3 = UITabBarItem(title: "", image: UIImage(named: "movie.png"), selectedImage: UIImage(named: "movie.png"))
        // fourth tab
        let st4 = UIStoryboard(name: "Weather", bundle: nil)
        let tab4 = st4.instantiateViewController(withIdentifier: "WeatherNavigationController") as! WeatherNavigationController
        let icon4 = UITabBarItem(title: "", image: UIImage(named: "weather.png"), selectedImage: UIImage(named: "weather.png"))
        tab4.tabBarItem = icon4
        tab3.tabBarItem = icon3
        tab2.tabBarItem = icon2
        tab1.tabBarItem = icon1
        let controllers = [tab1,tab2,tab3,tab4]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }

}
