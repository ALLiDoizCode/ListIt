//
//  PublicProfileViewController.swift
//  ListIt
//
//  Created by Chris Collins on 1/1/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class PublicProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var presentItems = getData()
    
    var itemData:[item] = []
    var itemType:[String] = ["Individual-Icon","Crowdsourced-Icon","Business-Icon-1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Josef"
        
        let leftButton =  UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.Plain, target: self, action: "popToRoot:")
    
         navigationItem.leftBarButtonItem = leftButton
        
        //parseData fill the aray for the listview items with this
        
        presentItems.getItem { (list) -> Void in
            
            self.itemData = list
            
            //the images are stored as url so as not to take up memory
            print("ItemIcon: \(list[0].icon)")
            print("UserIcon: \(list[0].userIcon)")
            print("Title: \(list[0].title)")
            print("Price: \(list[0].price)")
            print("Shares: \(list[0].shares)")
            print("Comments: \(list[0].comments)")
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.tableView.reloadData()
                
            });
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
   
    
    
   func popToRoot(sender:UIBarButtonItem){
        self.performSegueWithIdentifier("backToMain", sender: self)
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ListTableViewCell
        
        let ran = Int(arc4random_uniform(3))
        
        cell.listHeadingTitle.text = itemData[indexPath.row].title
        cell.listImage.kf_setImageWithURL(NSURL(string: itemData[indexPath.row].icon)!, placeholderImage: UIImage(named: "placeholder"))
        cell.userTypeIcon.image = UIImage(named: itemType[ran])
        cell.listPrice.text = "$\(itemData[indexPath.row].price)"
        cell.usersName.text = "Jonathan"
        cell.share.setTitle("\(itemData[indexPath.row].shares) Shares", forState: .Normal)
        cell.comment.setTitle("\(itemData[indexPath.row].comments) Comments", forState: .Normal)
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemData.count
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
