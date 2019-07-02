//
//  TabVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 5/28/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit

class TabVC: UITabBarController {

    
    @IBOutlet weak var slideMenu: UIBarButtonItem!
    
    var appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.slideMenuButton()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == tabBar.items?[0] {
            print("you click item one...")
            
            self.appdelegate.setUpMainView.set(nil, forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            let view = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")as! SWRevealViewController
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
        }
    }
    
    
    func slideMenuButton() {
        if revealViewController() != nil {
            slideMenu.target = revealViewController()
            slideMenu.action = #selector(SWRevealViewController.revealToggle(_:))
            
            revealViewController().rearViewRevealWidth = 270
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
            
        }
    }

  
}
