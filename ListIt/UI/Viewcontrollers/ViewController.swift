//
//  ViewController.swift
//  ListIt
//
//  Created by Jonathan Green on 12/8/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let venmo:PresentVenmo = PresentVenmo()
    let user:User = User()
    let parseData:getData = getData()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       

        // Do any additional setup after loading the view, typically from a nib.
        
       //populate variables with data and UI binding here
        self.venmo.getUser { (token) -> Void in
            let username = self.user.currentUser().user.username
            let userImage = self.user.currentUser().user.profileImageUrl
            print("The Token: \(token)")
            print("UserName: \(username)")
            print("User Image: \(userImage)")
            
            //reload table or collection view
        }

        
        //parseData fill the aray for the listview items with this
        self.parseData.getItem { (items) -> Void in
            
            //the images are stored as url so as not to take up memory
            print("ItemIcon: \(items[0].icon)")
            print("UserIcon: \(items[0].userIcon)")
            print("Title: \(items[0].title)")
            print("Price: \(items[0].price)")
            print("Shares: \(items[0].shares)")
            print("Comments: \(items[0].comments)")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

