//
//  MasterTabController.swift
//  userApp
//
//  Created by Lucas Da Silva on 30/06/20.
//  Copyright © 2020 Lucas Da Silva. All rights reserved.
//

import UIKit

class MasterTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupTabs()
    }

    fileprivate func setupTabs(){

        let navigationController = UINavigationController(rootViewController: TableViewController())
        navigationController.navigationBar.prefersLargeTitles = true

        let userScreenController = navigationController
        userScreenController.tabBarItem = UITabBarItem(title : "Users", image : UIImage(systemName: "person")!, tag: 0)

        let sampleScreenController = SampleScreen()
        sampleScreenController.tabBarItem = UITabBarItem(title: "Sample", image: UIImage(systemName: "questionmark")!, tag: 1)

        viewControllers = [userScreenController,sampleScreenController]
    }

    fileprivate func setupLayout(){
        tabBar.isTranslucent = true
        tabBar.barTintColor = UIColor.systemGroupedBackground
    }
}
