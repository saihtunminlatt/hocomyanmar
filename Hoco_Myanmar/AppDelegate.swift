//
//  AppDelegate.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 5/16/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import OneSignal
import NotificationCenter
import UserNotifications
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var firstUse : UserDefaults = UserDefaults()
    var myUrl :  UserDefaults = UserDefaults()
    var saveRemenberPwd : UserDefaults = UserDefaults()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()

        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        
        let first_use = appdelegate.firstUse.string(forKey: "noti")
        
        if first_use == nil {
            
            print("nil ...........")
            
            let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
            OneSignal.initWithLaunchOptions(launchOptions,
                                            appId: "5b2bba7c-8df0-42a1-8b3e-bcb48ada9481",
                                            handleNotificationAction: nil,
                                            settings: onesignalInitSettings)
            
            OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                print("User accepted notifications: \(accepted)")
            })
        }else if first_use == "on" {
            
            print("on ..............")
            
            let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
            OneSignal.initWithLaunchOptions(launchOptions,
                                            appId: "5b2bba7c-8df0-42a1-8b3e-bcb48ada9481",
                                            handleNotificationAction: nil,
                                            settings: onesignalInitSettings)
            
            OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                print("User accepted notifications: \(accepted)")
            })
        }else {
            print("off.............")
            
            let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
            OneSignal.initWithLaunchOptions(launchOptions,
                                            appId: "",
                                            handleNotificationAction: nil,
                                            settings: onesignalInitSettings)
            
            OneSignal.inFocusDisplayType = OSNotificationDisplayType.none;
            OneSignal.promptForPushNotifications(userResponse: { (fail) in
                print("User accepted notifications: \(fail)")
            })
        }
        
        
            NotificationCenter.default.addObserver(forName: Notification.Name("on"), object: nil, queue: nil, using: { (success) in
            print("You are on state..")
            
            let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
            OneSignal.initWithLaunchOptions(launchOptions,
                                            appId: "5b2bba7c-8df0-42a1-8b3e-bcb48ada9481",
                                            handleNotificationAction: nil,
                                            settings: onesignalInitSettings)
            
            OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
            OneSignal.promptForPushNotifications(userResponse: { accepted in
                print("User accepted notifications: \(accepted)")
            })
        })
    
        NotificationCenter.default.addObserver(forName: Notification.Name("off"), object: nil, queue: nil, using: { (success) in
            print("You are off state..")
           
            
            let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
            OneSignal.initWithLaunchOptions(launchOptions,
                                            appId: "",
                                            handleNotificationAction: nil,
                                            settings: onesignalInitSettings)
            
//            OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
//            OneSignal.promptForPushNotifications(userResponse: { accepted in
//                print("User accepted notifications: \(accepted)")
//            })
            
            OneSignal.inFocusDisplayType = OSNotificationDisplayType.none;
            OneSignal.promptForPushNotifications(userResponse: { (fail) in
                print("User accepted notifications: \(fail)")
            })
            
        })
      
        return true
    }
    
    
    
    

    
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
      
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
 
 
}

