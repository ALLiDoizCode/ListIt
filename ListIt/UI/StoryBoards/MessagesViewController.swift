//
//  MessagesViewController.swift
//  ListIt
//
//  Created by Chris Collins on 1/3/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class MessagesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var presenter = getData()
    
    var messageArray:[item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        presenter.getItem { (item) -> Void in
            
            self.messageArray = item
            
            self.reloadMessagesView()
        }

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadMessagesView() {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.tableView?.reloadData()
            
        });
    
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return messageArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:MessagesCell = tableView.dequeueReusableCellWithIdentifier("messages", forIndexPath: indexPath) as! MessagesCell
        
        cell.userIcon.kf_setImageWithURL(NSURL(string: messageArray[indexPath.row].userIcon)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: .None)
        
        cell.theDescription.text = messageArray[indexPath.row].description
        cell.listingTitle.text = messageArray[indexPath.row].title
        cell.time.text = messageArray[indexPath.row].time
        
        return cell
        
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
