//
//  Home.swift
//  ListIt
//
//  Created by Jonathan Green on 1/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class Home: UIViewController {

   
    @IBOutlet weak var signUP: UIButton!
    @IBOutlet weak var login: UIButton!
    
    
    override func viewWillAppear(animated: Bool) {
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUP.layer.cornerRadius = 5
        signUP.layer.masksToBounds = true
        login.layer.cornerRadius = 5
        login.layer.masksToBounds = true
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signUpBtn(sender: AnyObject) {
    }
    @IBAction func loginBtn(sender: AnyObject) {
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
