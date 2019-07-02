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
    
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var btnAppStore: UIButton!
    @IBOutlet weak var notiSwitch: UISwitch!
    
    var currentEmail : String = ""
    
    var mymanager = dbmanager()
    var myarray = [My_DB]()
    
    var username : String = ""
    
    override func viewDidLoad() {
        
        userView.isHidden = true
        super.viewDidLoad()
        self.hideLoding()
        
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

        self.myarray = mymanager.getAll()
        for aa in myarray {
            self.username = aa.username
        }
        
        self.userEmail.text = username

        var showView = self.appdelegate.viewChange.string(forKey: "view")
        
        if showView == "true" {
            userView.isHidden = false
        }else if showView == "false" {
            userView.isHidden = true
            
        }
    }
   
    @IBAction func onClickAppStoreView(_ sender: UIButton) {
  
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
    
    
    //:->showloading
    func showLoading(){
        self.view.isUserInteractionEnabled = false
        IHProgressHUD.set(backgroundColor: UIColor.clear)
        IHProgressHUD.set(foregroundColor: UIColor.lightGray)
        IHProgressHUD.show()
        
    }
    @IBAction func onClickSignUp(_ sender: UIButton) {
        let view = storyboard?.instantiateViewController(withIdentifier: "SignupOrSkipVC")as! SignupOrSkipVC
        view.modalTransitionStyle = .crossDissolve
        self.present(view, animated: true, completion: nil)
    }
    
    func hideLoding(){
        self.view.isUserInteractionEnabled = true
        IHProgressHUD.dismiss()
        
      }
  
    
}

