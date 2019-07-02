
//
//  SplashScreenVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 5/16/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit

class SplashScreenVC: UIViewController {

    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    var mymanager = dbmanager()
    var myarray = [My_DB]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.HandleSplashScreen()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.myarray = mymanager.getAll()
        
        self.HandleSplashScreen()
    }
    
    func HandleSplashScreen(){
         Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(HandleTimer), userInfo: nil, repeats: false)
    }
    
    @objc func HandleTimer() {
        
        let mystring = self.appdelegate.handleSignupform.string(forKey: "viewChange")
        
        if mystring == "true"{
            let view = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")as! SWRevealViewController
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
            
        }else if mystring == nil {
            let view = self.storyboard?.instantiateViewController(withIdentifier: "InfoOneVC")as! InfoOneVC
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
            
            }
        }

}
