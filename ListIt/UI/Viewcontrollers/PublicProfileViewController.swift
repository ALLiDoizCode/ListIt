//
//  PublicProfileViewController.swift
//  ListIt
//
//  Created by Chris Collins on 1/1/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class PublicProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Josef"
        
        //  let navigationBar = navigationController!.navigationBar
        //navigationBar.tintColor = UIColor.blueColor()
        
        let leftButton =  UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "popToRoot:")
        
        
         navigationItem.leftBarButtonItem = leftButton
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    
    
   func popToRoot(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("backToMain", sender: self)
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("public")
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
