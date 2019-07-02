//
//  dbmanager.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 6/18/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class dbmanager : NSObject {
    func add(username : String, password : String){
        let mydb = My_DB()
        
        mydb.id = mydb.incrementID()
        mydb.username = username
        mydb.password = password
        
        let realm = try! Realm()
        try! realm.write {
            realm.add(mydb)
        }
    }
    
    func getAll()-> Array<My_DB> {
        var myarray = [My_DB]()
        let realm = try! Realm()
        
        var mydata = realm.objects(My_DB.self)
        
        mydata = mydata.sorted(byKeyPath: "id", ascending: true)
        
        for getdata in mydata {
            myarray.append(getdata)
        }
        return myarray
  
   }
    
    func deleteMydb(){
        
        let realm = try! Realm()
        let repeatedItem = realm.objects(My_DB.self)
        
        if repeatedItem.count != 0{
            
            try! realm.write {
                realm.delete(repeatedItem)
            }
        }
        
        
    }
    
}
