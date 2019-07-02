//
//  PowerView.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 6/21/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import Alamofire
import IHProgressHUD

class PowerView: UIView, UIWebViewDelegate {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var webView: UIWebView!

    let myUrl : String = "https://www.hocomyanmar.com/products/list?category_id=14"

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
