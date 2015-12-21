//
//  AddListingViewController.swift
//  ListIt
//
//  Created by Chris Collins on 12/17/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class AddListingViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var MainImageView: UIScrollView!
    @IBOutlet weak var firstImage: UIImageView!
    
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
  
    @IBOutlet weak var headline: UITextField!
    @IBOutlet weak var shortDescription: UITextField!
    @IBOutlet weak var listingType: UILabel!
    @IBOutlet weak var selectCategory: UILabel!
    @IBOutlet weak var listPrice: UITextField!
    
    @IBOutlet weak var shareFacebook: UITextField!
    @IBOutlet weak var shareToggle: UISwitch!
    
    
    
    
    override func viewDidLayoutSubviews()
    {
        
        firstImage.layer.cornerRadius = 10
        firstImage.layer.masksToBounds = true
        
        secondImage.layer.cornerRadius = 10
        secondImage.layer.masksToBounds = true
        
        thirdImage.layer.cornerRadius = 10
        thirdImage.layer.masksToBounds = true
        
         shareToggle.transform = CGAffineTransformMakeScale(0.75, 0.75)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillDisappear(animated)
        
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
