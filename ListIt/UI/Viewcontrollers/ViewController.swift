//
//  ViewController.swift
//  ListIt
//
//  Created by Jonathan Green on 12/8/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let user:User = User()
    let manger:NetworkManger = NetworkManger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        user.login()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

