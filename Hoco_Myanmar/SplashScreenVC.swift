
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

       self.HandleSplashScreen()
        
    }
    
    func HandleSplashScreen(){
         Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(HandleTimer), userInfo: nil, repeats: false)
    }
    
    @objc func HandleTimer() {
        let checkRememberPwd = self.appdelegate.saveRemenberPwd.string(forKey: "check")
        
        if checkRememberPwd == nil {
            let view = storyboard?.instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
            
        }else if checkRememberPwd == "true" {
            let view = storyboard?.instantiateViewController(withIdentifier: "TabVC")as! TabVC
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
            
        }else if checkRememberPwd == "false" {
            let view = storyboard?.instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
            
        }else if checkRememberPwd == "success" {
            let view = storyboard?.instantiateViewController(withIdentifier: "TabVC")as! TabVC
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
            
        }
       
    }

   
}
