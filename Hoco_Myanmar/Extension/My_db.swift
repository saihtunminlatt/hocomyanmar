//
//  My_db.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 6/18/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class My_DB : Object {
    @objc dynamic var id :Int = 0
    @objc dynamic var username : String = ""
    @objc dynamic var password : String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func incrementID() -> Int {
        let realm = try! Realm()
        
        return (realm.objects(My_DB.self).max(ofProperty: "id") as Int? ?? 0)+1
    }
    
}

