//
//  SignupOrSkipVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 6/26/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit

class SignupOrSkipVC: UIViewController {

    var appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var bannerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        bannerView.backgroundColor = UIColor.clear
        
        bannerImage.layer.masksToBounds = true
        bannerImage.layer.cornerRadius = 10

//        bannerView.layer.masksToBounds = true
//        bannerView.layer.cornerRadius = 10
//
//        
        bannerView.layer.shadowColor = UIColor.gray.cgColor
        bannerView.layer.shadowOpacity = 5
        bannerView.layer.shadowRadius = 5
        bannerView.layer.shadowOffset = CGSize(width: 0, height: 10)
        
       
    }
    

    @IBAction func onclickSignUp(_ sender: Any) {
        
        self.appdelegate.handleSignupform.set("true", forKey: "viewChange")
        self.appdelegate.setUpMainView.set(nil, forKey: "main")
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SearchVC")as!  SearchVC
        
        view.modalTransitionStyle = .crossDissolve
        
        self.present(view,animated: true, completion: nil)
        
    }
    
    @IBAction func onclickSkip(_ sender: Any) {
        self.appdelegate.setUpMainView.set(nil, forKey: "main")

          self.appdelegate.viewChange.set("true", forKey: "view")
        self.appdelegate.handleSignupform.set("true", forKey: "viewChange")

        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")as!  SWRevealViewController
        
        view.modalTransitionStyle = .crossDissolve
        
        self.present(view,animated: true, completion: nil)
    }
}
