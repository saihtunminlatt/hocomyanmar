//
//  HomeVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 5/28/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import Alamofire
import IHProgressHUD

class HomeVC: UIViewController,UIScrollViewDelegate,UIWebViewDelegate {

    var appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    var name : String = ""
    var id : String = ""
    
    var myWebView = UIWebView()
    
    @IBOutlet weak var mainView: UIView!
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
         
            let mystring = appdelegate.search.string(forKey: "search")
            
            self.id = appdelegate.id.string(forKey: "id") ?? ""
            self.name = appdelegate.name.string(forKey: "name") ?? ""
            
            if mystring == "true" {
                self.mainView.isHidden = true
                
                myWebView.reload()

                 myWebView = UIWebView(frame: CGRect(x:0, y:0, width: view.frame.size.width, height:view.frame.size.height))

                self.view.addSubview(myWebView)

                myWebView.delegate = self

                let myURL = URL(string: "https://www.hocomyanmar.com/products/list?category_id=\(id)&name=\(name)")
                let myURLRequest:URLRequest = URLRequest(url: myURL!)
                myWebView.loadRequest(myURLRequest)
                
            }else if mystring == "false" {
                self.mainView.isHidden = false
                setUpView()
            }else if mystring == nil {
                self.mainView.isHidden = false
                setUpView()
            }
            

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
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.showLoading()

    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.hideLoding()
        self.view.isUserInteractionEnabled = true

    }
    
    func setUpView() {
        if NetworkManager.isConnected() == true {
        self.showLoading()
            
            let myheight = mainView.frame.size.height
            let mywidth  = mainView.frame.size.width
            
            let myview = self.appdelegate.setUpMainView.string(forKey: "main")
            
            if myview == nil {
                if let xibview = Bundle.main.loadNibNamed("HomeView", owner: self, options: nil)?.first as? HomeView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                  }
            }else if myview == "selfie" {
                    if let xibview = Bundle.main.loadNibNamed("SelfieView", owner: self, options: nil)?.first as? SelfieView{
                        xibview.frame.size.height = myheight
                        xibview.frame.size.width = mywidth
                        
                        self.mainView.addSubview(xibview)
                }
            }else if myview == "mobile" {
                if let xibview = Bundle.main.loadNibNamed("MobileView", owner: self, options: nil)?.first as? MobileView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                }
            }else if myview == "power" {
                if let xibview = Bundle.main.loadNibNamed("PowerView", owner: self, options: nil)?.first as? PowerView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                }
            }else if myview == "wireless" {
                if let xibview = Bundle.main.loadNibNamed("WirelessView", owner: self, options: nil)?.first as? WirelessView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                }
            }else if myview == "earphone" {
                if let xibview = Bundle.main.loadNibNamed("EarphoneView", owner: self, options: nil)?.first as? EarphoneView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                }
            }else if myview == "smart" {
                if let xibview = Bundle.main.loadNibNamed("SmartChargerView", owner: self, options: nil)?.first as? SmartChargerView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                }
            }else if myview == "car" {
                if let xibview = Bundle.main.loadNibNamed("CarChargerView", owner: self, options: nil)?.first as? CarChargerView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                }
            }else if myview == "cart" {
                if let xibview = Bundle.main.loadNibNamed("CartView", owner: self, options: nil)?.first as? CartView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                }
            }else if myview == "signup" {
                if let xibview = Bundle.main.loadNibNamed("SignupView", owner: self, options: nil)?.first as? SignupView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                }
            }else if myview == "favourite" {
                if let xibview = Bundle.main.loadNibNamed("FavouriteView", owner: self, options: nil)?.first as? FavouriteView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                }
            }else if myview == "signin" {
                if let xibview = Bundle.main.loadNibNamed("SigninView", owner: self, options: nil)?.first as? SigninView{
                    xibview.frame.size.height = myheight
                    xibview.frame.size.width = mywidth
                    
                    self.mainView.addSubview(xibview)
                }
            }
            
                
        }else {
            
            let alert = UIAlertController(title: "No Internet!", message: "Make sure your device is connected to internet.", preferredStyle: .alert)
            
            let okbutton = UIAlertAction(title: "Reload", style: .default, handler: {(_ alert: UIAlertAction) -> Void in
                self.showLoading()
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.HandleReloadView), userInfo: nil, repeats: false)
                
            })
            
            alert.addAction(okbutton)
            
            self.present(alert,animated: true)
            
        }
            
    }
        
    @objc func HandleReloadView() {
        self.setUpView()
    }
    

}

