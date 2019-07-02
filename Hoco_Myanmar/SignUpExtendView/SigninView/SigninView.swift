//
//  SigninView.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 6/21/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import Alamofire
import IHProgressHUD

class SigninView: UIView,UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var mainView: UIView!
    
    let myUrl : String = "https://www.hocomyanmar.com/logout"
    
    override func awakeFromNib() {
        webView.reload()
        setUpView()
    }
    
    //:- set up view
    func setUpView(){
        
        let homeurl = URL(string: myUrl)
        webView.loadRequest(URLRequest(url: homeurl!))
        webView.delegate = self
        
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        self.showLoading()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.hideLoding()
    }
    
    func showLoading(){
        mainView.isUserInteractionEnabled = false
        IHProgressHUD.set(backgroundColor: UIColor.clear)
        IHProgressHUD.set(foregroundColor: UIColor.lightGray)
        IHProgressHUD.show()
        
    }
    func hideLoding(){
        mainView.isUserInteractionEnabled = true
        IHProgressHUD.dismiss()
        
    }


}
