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
        let icon1 = UITabBarItem(title: "Stock", image: UIImage(named: "stock.png"), selectedImage: UIImage(named: "stock.png"))
        // second tab
        let st2 = UIStoryboard(name: "Music", bundle: nil)
        let tab2 = st2.instantiateViewController(withIdentifier: "MusicSearchViewController") as! MusicSearchViewController
        let icon2 = UITabBarItem(title: "Music", image: UIImage(named: "stock.png"), selectedImage: UIImage(named: "stock.png"))
        tab2.tabBarItem = icon2
        tab1.tabBarItem = icon1
        let controllers = [tab1,tab2]  //array of the root view controllers displayed by the tab bar interface
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
