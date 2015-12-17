//
//  AddListingViewController.swift
//  ListIt
//
//  Created by Chris Collins on 12/17/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class AddListingViewController: UIViewController {

    @IBOutlet weak var MainImageView: UIScrollView!
    @IBOutlet weak var firstImage: UIImageView!
    
    override func viewDidLayoutSubviews() {
        
       firstImage.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
