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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        self.venmo.getToken { (token) -> Void in
           //poulate variables with data and ui binding here
            let username = self.user.currentUser().user.username
            print("The Token: \(token)")
            print(username)
            
            //reload table or collection view
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

