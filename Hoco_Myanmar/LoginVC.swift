//
//  LoginVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 6/10/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import Firebase
import IHProgressHUD
import Alamofire

class LoginVC: UIViewController,UITextFieldDelegate {

   
    @IBOutlet weak var rememberPwd: UIButton!
    
    
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var errorUserName: UIImageView!
    @IBOutlet weak var errorPassword: UIImageView!
    
    @IBOutlet weak var erroView: UIView!
    @IBOutlet weak var lblError: UILabel!
    var currentUserEmail : String = ""
    
     var isCheck: Bool = true
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        erroView.isHidden = true
        
        errorUserName.isHidden = true
        errorPassword.isHidden = true
        
        let check = appdelegate.saveRemenberPwd.string(forKey: "check")
        
        if check == "true"{
            rememberPwd.setBackgroundImage(UIImage(named: "checkmark"), for: .normal)

        }else if check == "false"{
            rememberPwd.setBackgroundImage(UIImage(named: ""), for: .normal)
        }
        
        //print("app delegate...\(check)")
        
        txtUserName.delegate = self
        txtPassword.delegate = self
        
        logoImgView.layer.masksToBounds = true
        logoImgView.layer.cornerRadius = 15
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleScreenTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        
        rememberPwd.addTarget(self, action: #selector(handleToogleButton), for: .touchUpInside)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        txtUserName.text = currentUserEmail
    }
    
    @objc func handleToogleButton(){
        if txtUserName.text == "" && txtPassword.text == "" {
            let alert = UIAlertController(title: "", message: "Please fill username and password!", preferredStyle: .alert)
            
            let okbutton = UIAlertAction(title: "Ok", style: .default, handler: {(_ alert: UIAlertAction) -> Void in
                
            })
            
         
            alert.addAction(okbutton)
            
            self.present(alert,animated: true)
            
        }else {
            
            isCheck = !isCheck
            if isCheck {
                rememberPwd.setBackgroundImage(UIImage(named: ""), for: .normal)
//                self.appdelegate.saveRemenberPwd.set("false", forKey: "check")
                
            } else {
                rememberPwd.setBackgroundImage(UIImage(named: "checkmark"), for: .normal)
                self.appdelegate.saveRemenberPwd.set("true", forKey: "check")
            }
        }
        
       
     
    }
   
    //:-> handle tap screen
    @objc func handleScreenTap(_ sender : UITapGestureRecognizer){
        self.view.endEditing(true)
    }
    
    
    //:->create user
    func createUser(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error == nil {
                print("User create...")
                self.signInUser(email: email, password: password)
            }else {
                print(error!.localizedDescription)
                self.showError(result: error!.localizedDescription)
                self.txtUserName.text = ""
                self.txtPassword.text = ""
                
            }
        }
    }
    
    //:->sign in user
    func signInUser(email: String, password: String){
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error == nil {

                print("user sign in ...")
                self.appdelegate.saveRemenberPwd.set("success", forKey: "check")
                self.viewChange()

            }else if (error?._code == AuthErrorCode.userNotFound.rawValue){

               self.createUser(email: email, password: password)

            }else {
                let errorCode = AuthErrorCode(rawValue: error!._code)
                
                switch errorCode {
                case .wrongPassword?:
                    print("Wrong Password..")
                   
                    self.showError(result: "Incorrect password or Email already exist!")
                    self.txtPassword.text = ""

                    break
                default:
                    print(error!.localizedDescription)
                    
                    self.showError(result: error!.localizedDescription)
                    self.txtUserName.text = ""
                    self.txtPassword.text = ""
                    
                   break
                }
            }
           
        }
    }
    
    //:->show error
    func showError(result : String){
        UIView.animate(withDuration: 1){
            self.hideLoding()
            self.erroView.isHidden = false
            self.lblError.text = result
        }
    }
    
    //:-> handle keyboard..
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    
    
    //:->Signin btn.
    @IBAction func clickSignInBtn(_ sender: UIButton) {
        
        if NetworkManager.isConnected() == true{
            self.showLoading()
            
            if txtUserName.text == "" && txtPassword.text == ""{
                errorUserName.isHidden = false
                errorPassword.isHidden = false
                
                showError(result: "User name and password must required!")
            }else if txtUserName.text == "" && txtPassword.text != ""{
                errorUserName.isHidden = false
                errorPassword.isHidden = true
                
                showError(result: "Username Required!")
            }else if txtUserName.text != "" && txtPassword.text == ""{
                errorPassword.isHidden = false
                errorUserName.isHidden = true
                
                showError(result: "Password Required!")
            }else if txtUserName.text != "" && txtPassword.text != ""{
                self.signInUser(email: txtUserName.text!, password: txtPassword.text!)
            }
            
        }else {
            let alert = UIAlertController(title: "No Internet!", message: "Make sure your device is connected to internet.", preferredStyle: .alert)
            
            let okbutton = UIAlertAction(title: "Ok", style: .default, handler: {(_ alert: UIAlertAction) -> Void in
            })
            
            alert.addAction(okbutton)
            
            self.present(alert,animated: true)
            
        }

        
       
        
        
    }
    
    func viewChange(){
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(viewChangeWithTimer), userInfo: nil, repeats: false)
    }
    
    //:handle view change
    @objc func viewChangeWithTimer(){
        self.hideLoding()
        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "TabVC")as! TabVC
        self.present(view, animated: true, completion: nil)
    }
    
    @IBAction func closeErrorAlert(_ sender: UIButton) {
        UIView.animate(withDuration: 2){
            self.erroView.isHidden = true
        }
        errorUserName.isHidden = true
        errorPassword.isHidden = true
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
