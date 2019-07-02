//
//  SlideTableVC.swift
//  Hoco_Myanmar
//
//  Created by ALAY on 6/21/19.
//  Copyright © 2019 Aerial-Yangon. All rights reserved.
//

import UIKit
import DropDown

class SlideTableVC: UITableViewController {

    @IBOutlet weak var txtSearchBar: UITextField!
    @IBOutlet weak var mainView: UIView!
    
    var appdelegate = UIApplication.shared.delegate as! AppDelegate

    
    let dropDown = DropDown()
    
    var myid : String = ""
    
    @IBOutlet weak var searchBtn: UIImageView!
    @IBOutlet weak var dropdownbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.masksToBounds = true
        mainView.layer.cornerRadius = 10
        setUpDropDown()


    }
    
    @IBAction func onclickButton(_ sender: Any) {
        dropDown.show()
    }
    func setUpDropDown() {
        dropDown.anchorView = dropdownbtn
        
        dropDown.dataSource = ["All Products", "Selfie Sticks", "Molbile holders", "Power banks", "Wireless Speakers", "Earphones", "Smart chargers", "Car chargers"]
        dropDown.cellNib = UINib(nibName: "MyCell", bundle: nil)
        
        
        dropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? MyCell else { return }
            
        }
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            self.dropdownbtn.setTitle(item, for: .normal)
            
            if index == 0 {
               self.myid = ""
               self.carryID(myid: "")
                
            }else if index == 1 {
               self.myid = "16"
                self.carryID(myid: "16")
                
            }else if index == 2 {
                self.myid = "15"
                self.carryID(myid: "15")


            }else if index == 3 {
                self.myid = "14"
                self.carryID(myid: "14")


            }else if index == 4 {
                self.myid = "11"
                self.carryID(myid: "11")


            }else if index == 5 {
                self.myid = "10"
                self.carryID(myid: "10")


            }else if index == 6 {
                self.myid = "8"
                self.carryID(myid: "8")


            }else if index == 7 {
                self.myid = "7"
                self.carryID(myid: "7")


            }
        }
        
        dropDown.width = 300
        
        
     }
    
    
    //carry data
    func carryID(myid : String){
        self.appdelegate.id.set(myid, forKey: "id")
    }
    
    @IBAction func onclickSearch(_ sender: Any) {
        
        self.appdelegate.search.set("true", forKey: "search")
        if txtSearchBar.text == "" {
            self.appdelegate.name.set("", forKey: "name")
        }else {
            self.appdelegate.name.set(txtSearchBar.text, forKey: "name")
        }
       
        
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")as! SWRevealViewController

        view.modalTransitionStyle = .crossDissolve
        self.present(view, animated: true, completion: nil)
    }
    
    func viewChange() {
        let myview = self.storyboard?.instantiateViewController(withIdentifier: "SWRevealViewController")as! SWRevealViewController
        
        self.present(myview, animated: true, completion: nil)
    }
    
    //end
    
    @IBAction func onclickEndSection(_ sender: UIButton) {
        if sender.tag == 0 {
            self.appdelegate.setUpMainView.set("cart", forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()
        }else if sender.tag == 1 {
            self.appdelegate.setUpMainView.set("signup", forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()
        }else if sender.tag == 2 {
            self.appdelegate.setUpMainView.set("favourite", forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()
        }else if sender.tag == 3 {
            self.appdelegate.setUpMainView.set("signin", forKey: "main")
            self.appdelegate.viewChange.set("true", forKey: "view")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()
        }
        
    }
    
    @IBAction func onclickHome(_ sender: UIButton) {
        self.appdelegate.setUpMainView.set(nil, forKey: "main")
        self.appdelegate.search.set("false", forKey: "search")

        self.viewChange()
    }
    
    
    ///middle
    @IBAction func OnclickSelectCategories(_ sender: UIButton) {
        if sender.tag == 1 {
           self.appdelegate.setUpMainView.set("selfie", forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()
            
        }else if sender.tag == 2 {
            self.appdelegate.setUpMainView.set("mobile", forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()
            
        }else if sender.tag == 3 {
            self.appdelegate.setUpMainView.set("power", forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()

        }else if sender.tag == 4 {
            self.appdelegate.setUpMainView.set("wireless", forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()

        }else if sender.tag == 5 {
            self.appdelegate.setUpMainView.set("earphone", forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()

        }else if sender.tag == 6 {
            self.appdelegate.setUpMainView.set("smart", forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()

        }else if sender.tag == 7 {
            self.appdelegate.setUpMainView.set("car", forKey: "main")
            self.appdelegate.search.set("false", forKey: "search")

            self.viewChange()

        }
        
        
        
    }
    
    
  
    

    }
    




