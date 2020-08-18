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
        let st = UIStoryboard(name: "Finance", bundle: nil)
        let item1 = st.instantiateViewController(withIdentifier: "FinanceNavigationController") as! FinanceNavigationController
        let icon1 = UITabBarItem(title: "Stock", image: UIImage(named: "stock.png"), selectedImage: UIImage(named: "stock.png"))
        item1.tabBarItem = icon1
        let controllers = [item1]  //array of the root view controllers displayed by the tab bar interface
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
