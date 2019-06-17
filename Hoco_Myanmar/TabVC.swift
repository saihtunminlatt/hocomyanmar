//
//  TabVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 5/28/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit

class TabVC: UITabBarController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == tabBar.items?[0] {
            print("you click item one...")
            
            if let tabbar = (storyboard!.instantiateViewController(withIdentifier: "TabVC") as? UITabBarController) {
                self.present(tabbar, animated: true, completion: nil)
            }
        }
    }
  
}
