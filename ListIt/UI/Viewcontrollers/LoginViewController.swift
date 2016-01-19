//
//  LoginViewController.swift
//  ListIt
//
//  Created by Jonathan Green on 1/17/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import SwiftEventBus


class LoginViewController: UIViewController {
    
    let presenter = getData()
    let venmoPresenter = PresentVenmo()

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var confirm: UIButton!
    @IBOutlet weak var faceBook: UIButton!
    @IBOutlet weak var venmo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    @IBAction func confirmBtn(sender: AnyObject) {
        
        if email.text != "" && passWord.text != "" {
            
            SwiftEventBus.onMainThread(self, name: "SignedIn", handler: { (result) -> Void in
                
                self.performSegueWithIdentifier("success", sender: self)
                SwiftEventBus.unregister(self, name: "SignedIn")
            })
            
            presenter.login(email.text!, passWord: passWord.text!)
        }

    }
    
    
    @IBAction func faceBookBtn(sender: AnyObject) {
        
        SwiftEventBus.onMainThread(self, name: "SignedIn", handler: { (result) -> Void in
            
            self.performSegueWithIdentifier("success", sender: self)
            SwiftEventBus.unregister(self, name: "SignedIn")
        })
        
        presenter.signUpFaceBook()
    }
    

    @IBAction func venmoBtn(sender: AnyObject) {
        
        //populate variables with data and UI binding here
        self.venmoPresenter.getUser { (token) -> Void in
            //let username = self.user.currentUser().user.username
            //let userImage = self.user.currentUser().user.profileImageUrl
            print("The Token: \(token)")
            //print("UserName: \(username)")
            //print("User Image: \(userImage)")
            
            //reload table or collection view
        }
        
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
