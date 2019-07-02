//
//  FavouriteVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 5/28/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import IHProgressHUD
import Alamofire

class FavouriteVC: UIViewController,UIWebViewDelegate {

    var myUrl : String = "https://www.hocomyanmar.com/mypage/favorite"

    @IBOutlet weak var FavouriteWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FavouriteWebView.reload()
        self.setUpView()
    }
    

    //:- set up view
    func setUpView(){
        if NetworkManager.isConnected() == true {
            self.showLoading()
            let homeurl = URL(string: myUrl)
            FavouriteWebView.loadRequest(URLRequest(url: homeurl!))
            FavouriteWebView.delegate = self
            
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
    
    override func viewDidAppear(_ animated: Bool) {
        FavouriteWebView.reload()
        self.hideLoding()
    }
    
    //:->webview start
    func webViewDidStartLoad(_ webView: UIWebView) {
        if NetworkManager.isConnected() == true{
            print("start...")
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
        print("finish...")
        self.hideLoding()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        if request.url?.absoluteString == "https://www.hocomyanmar.com/logout" {

            let view = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")as! SWRevealViewController
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
        }
        
        if request.url?.absoluteString == "https://www.hocomyanmar.com/"{

            let view = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")as! SWRevealViewController
            view.modalTransitionStyle = .crossDissolve
            self.present(view, animated: true, completion: nil)
        }
        
        return true
    }
    
    @IBAction func onClickBack(_ sender: Any) {
       self.dismiss(animated: true, completion: nil)
        
    }
    
 
}
