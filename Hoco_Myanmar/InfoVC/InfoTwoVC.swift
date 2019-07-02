//
//  InfoTwoVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 6/26/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import IHProgressHUD

class InfoTwoVC: UIViewController {

    var appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func onclickGetStarted(_ sender: Any) {
        self.showLoading()
        
        self.appdelegate.handleSignupform.set("true", forKey: "viewChange")
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(viewChange), userInfo: nil, repeats: false)
    }
    
    @objc func viewChange() {
        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SignupOrSkipVC")as! SignupOrSkipVC
        view.modalTransitionStyle = .crossDissolve
        self.present(view, animated: true, completion: nil)
        
    }
    
    func showLoading(){
        self.view.isUserInteractionEnabled = true
        IHProgressHUD.set(backgroundColor: UIColor.clear)
        IHProgressHUD.set(foregroundColor: UIColor.lightGray)
        IHProgressHUD.show()
        
    }
    func hideLoding(){
        self.view.isUserInteractionEnabled = false
        IHProgressHUD.dismiss()
        
    }
    
}
