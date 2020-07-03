//
//  TabBarController.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/29/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor(red: 119.0/255.0, green: 29.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
