//
//  ConfigurationVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 5/27/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import OneSignal
import IHProgressHUD
import Firebase

class ConfigurationVC: UIViewController {
   
    var appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var btnAppStore: UIButton!
    @IBOutlet weak var notiSwitch: UISwitch!
    
    var currentEmail : String = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       btnAppStore.layer.cornerRadius = 5
       btnAppStore.layer.masksToBounds = true
        
        let check_noti = self.appdelegate.firstUse.string(forKey: "noti")
        
        if check_noti == nil {
            print("nil state")
            notiSwitch.isOn = true
        }else if check_noti == "on" {
            print("on state")
            notiSwitch.isOn = true
        }else {
            print("off state")
            notiSwitch.isOn = false
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let useremaiil = Auth.auth().currentUser?.email
        
        self.currentEmail = useremaiil!
        
        self.userEmail.text = currentEmail

    }
   
    @IBAction func onClickAppStoreView(_ sender: UIButton) {
        exit(0)
    }
    
  
    @IBAction func onClickSwitch(_ sender: UISwitch) {
        if sender.isOn {
            self.appdelegate.firstUse.set("on", forKey: "noti")
            NotificationCenter.default.post(name: NSNotification.Name("on"), object: nil)
            
        }else {
            self.appdelegate.firstUse.set("off", forKey: "noti")
             NotificationCenter.default.post(name: NSNotification.Name("off"), object: nil)
        }
    }
    
    func viewChange(){
        let view = storyboard?.instantiateViewController(withIdentifier: "SplashScreenVC")as! SplashScreenVC
        view.modalTransitionStyle = .crossDissolve
        self.present(view, animated: true, completion: nil)
    }
    
    @IBAction func onclickSignOut(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Hello User", message: "Are you sure to logout?", preferredStyle: .alert)
        
        let okbutton = UIAlertAction(title: "Ok", style: .default, handler: {(_ alert: UIAlertAction) -> Void in
            self.appdelegate.saveRemenberPwd.set("false", forKey: "check")
            
            self.showLoading()
            self.viewChangeToLoginVC()
            
        })
        
        let cancelBtn = UIAlertAction(title: "Cancel", style: .default, handler: {(_ alert: UIAlertAction) -> Void in
        })
        
        alert.addAction(okbutton)
        alert.addAction(cancelBtn)
        
        self.present(alert,animated: true)
        
        
    }
    
    func viewChangeToLoginVC(){
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(viewChangeWithTimer), userInfo: nil, repeats: false)
    }
    
    //:handle view change
    @objc func viewChangeWithTimer(){
        self.hideLoding()
        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC")as! LoginVC
        view.modalTransitionStyle = .crossDissolve
        self.present(view, animated: true, completion: nil)
    }
    
    //:->showloading
    func showLoading(){
        self.view.isUserInteractionEnabled = false
        IHProgressHUD.set(backgroundColor: UIColor.clear)
        IHProgressHUD.set(foregroundColor: UIColor.lightGray)
        IHProgressHUD.show()
        
    }
    
    func hideLoding(){
        self.view.isUserInteractionEnabled = true
        IHProgressHUD.dismiss()
        
    }
  
}
