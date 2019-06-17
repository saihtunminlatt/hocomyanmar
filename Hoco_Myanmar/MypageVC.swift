//
//  MypageVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 5/28/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import IHProgressHUD
import Alamofire

class MypageVC: UIViewController,UIWebViewDelegate {
    
    //@IBOutlet weak var webView: WKWebView!
    
    
    @IBOutlet weak var MypageWebView: UIWebView!
    var myUrl : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoading()
        
        MypageWebView.reload()

        myUrl = "https://www.hocomyanmar.com/mypage/login"
        
         self.setUpView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        MypageWebView.reload()
        
        self.setUpView()
        
        self.hideLoding()
    }
    
  
    
    //:- set up view
    func setUpView(){
        if NetworkManager.isConnected() == true {
            self.showLoading()
            let homeurl = URL(string: myUrl)
            MypageWebView.loadRequest(URLRequest(url: homeurl!))
            MypageWebView.delegate = self
            self.hideLoding()
            
        }else {
            self.hideLoding()
            let alert = UIAlertController(title: "No Internet!", message: "Make sure your device is connected to internet.", preferredStyle: .alert)
            
            let okbutton = UIAlertAction(title: "Reload", style: .default, handler: {(_ alert: UIAlertAction) -> Void in
                self.showLoading()
                Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.HandleReloadView), userInfo: nil, repeats: false)
                
            })
            
            alert.addAction(okbutton)
            
            self.present(alert,animated: true)
        }
    }
    
    //:-show loading
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


    //:->Handle reload alert button
    @objc func HandleReloadView(){
        self.setUpView()
    }
    
    //:->webview start
    func webViewDidStartLoad(_ webView: UIWebView) {
        if NetworkManager.isConnected() == true{
            self.showLoading()
            
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
    
    //:->webview finish
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("webView finish....")
       
      self.hideLoding()
        
    }
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        if request.url?.absoluteString == "https://www.hocomyanmar.com/logout" {
            if let tabbar = (storyboard!.instantiateViewController(withIdentifier: "TabVC") as? UITabBarController) {
                self.present(tabbar, animated: true, completion: nil)
            }
        }
        
        if request.url?.absoluteString == "https://www.hocomyanmar.com/"{
            if let tabbar = (storyboard!.instantiateViewController(withIdentifier: "TabVC") as? UITabBarController) {
                self.present(tabbar, animated: true, completion: nil)
            }
        }
        
        return true
    }
    
 

}
