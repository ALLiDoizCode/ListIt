//
//  DetailViewController.swift
//  ListIt
//
//  Created by Jonathan Green on 12/14/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var itemTitle: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var theDescription: UITextView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var shares: UILabel!
    @IBOutlet weak var comments: UILabel!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var userImgBtn: UIButton!
    
    
    var thePrice:String!
    var theTitle:String!
    var theImage:String!
    var itemDescription:String!
    var theTime:String!
    var theName:String!
    var theShares:String!
    var theComments:String!
    
    
    let venmo:PresentVenmo = PresentVenmo()
    let user:User = User()
    
    override func viewDidLayoutSubviews() {
        
        messageBtn.layer.cornerRadius = 3
        messageBtn.layer.masksToBounds = true
        
        userImgBtn.layer.cornerRadius = 15
        userImgBtn.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theDescription.textColor = UIColor.whiteColor()
        
        itemImage.kf_setImageWithURL(NSURL(string:theImage)!, placeholderImage: UIImage(named: "placeholder"))
        price.text = thePrice
        itemTitle.text = theTitle
        theDescription.text = itemDescription
        name.text = theName
        shares.text = theShares
        comments.text = theComments

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    
    @IBAction func message(sender: AnyObject) {
        
        /*//populate variables with data and UI binding here
           self.venmo.getUser { (token) -> Void in
        let username = self.user.currentUser().user.username
        let userImage = self.user.currentUser().user.profileImageUrl
        print("The Token: \(token)")
        print("UserName: \(username)")
        print("User Image: \(userImage)")
        
        }*/
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
