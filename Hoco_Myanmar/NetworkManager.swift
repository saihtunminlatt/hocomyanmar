//
//  NetworkManager.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 5/16/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    class func isConnected()-> Bool{
        return (NetworkReachabilityManager()?.isReachable)!
    }
}

