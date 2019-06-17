//
//  NotificationViewController.swift
//  NotificationContent
//
//  Created by ALAY on 5/17/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet var label: UILabel?
    var arrImages:[Data] = []

    
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        self.lblTitle.text = notification.request.content.title
        self.imgView.image = UIImage(named: notification.request.content.launchImageName)
    }

}
