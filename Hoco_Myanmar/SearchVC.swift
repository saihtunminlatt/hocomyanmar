//
//  SearchVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 6/21/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import IHProgressHUD
import Alamofire

class SearchVC: UIViewController,UIWebViewDelegate {

    //@IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var slideButton: UIBarButtonItem!
    var name : String = ""
    
    var myUrl : String = ""
    var id : String = ""
    
    var appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showLoading()
        self.myUrl = "https://www.hocomyanmar.com/entry"
        
        self.setUpView()
        webView.reload()
        
        
        
    }
 
    
    func setUpView(){
        if NetworkManager.isConnected() == true {
            self.showLoading()
            
            let homeurl = URL(string: myUrl)
            webView.loadRequest(URLRequest(url: homeurl!))
            webView.delegate = self
            
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
    
    @objc func HandleReloadView(){
        self.setUpView()
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
    
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        if NetworkManager.isConnected() == true{
            self.showLoading()
            print("start...")
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
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("finish...")
        self.hideLoding()
    }
    
    
    @IBAction func onclickSkipToHomeBtn(_ sender: Any) {
        
        self.appdelegate.viewChange.set("true", forKey: "view")
        self.appdelegate.setUpMainView.set(nil, forKey: "main")
        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")as! SWRevealViewController
        view.modalTransitionStyle = .crossDissolve
        self.present(view, animated: true, completion: nil)
    }
    
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        if request.url?.absoluteString == "https://www.hocomyanmar.com/" {
            
            self.appdelegate.viewChange.set("false", forKey: "view")

            let view = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")as! SWRevealViewController
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
        }
        
        return true
    }
    
    
    
}
