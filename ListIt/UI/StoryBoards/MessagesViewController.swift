//
//  MessagesViewController.swift
//  ListIt
//
//  Created by Chris Collins on 1/3/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class MessagesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    var presenter = getData()
    
    var messageArray:[item] = []
    var filtered:[item] = []
    var searchActive : Bool = false
    
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 75, 20))
    
    override func viewWillAppear(animated: Bool) {
        
        searchActive = false
        
        presenter.getItem { (item) -> Void in
            
            self.messageArray = item
            
            self.reloadMessagesView()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 100.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        setupSearchBar()

        // Do any additional setup after loading the view.
    }
    
    //Mark searcbar Protocols
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        var tempArray:[String] = []
        var tempFilter:[String] = []
        
        
        for var i = 0; i < messageArray.count; i++ {
            
            tempArray.append(messageArray[i].title)
            
        }
        
        tempFilter = tempArray.filter({ (text) -> Bool in
            let tmp: NSString = text
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        if(tempFilter.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
            
            filtered = []
            
            for var i = 0; i < tempFilter.count; i++ {
                
                for var j = 0; j < messageArray.count; j++ {
                    
                    if tempFilter[i] == messageArray[j].title {
                        
                        filtered.append(messageArray[j])
                    }
                    
                }
            }
        }
         self.reloadMessagesView()
    }
    
    
    func setupSearchBar(){
        searchBar.delegate = self
        searchBar.placeholder = "Type Here"
        searchBar.showsCancelButton = true
        searchBar.sizeToFit()
        self.navigationItem.titleView = searchBar
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
        
        if searchActive {
            
            return filtered.count
            
        }else {
            
            return messageArray.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:MessagesCell = tableView.dequeueReusableCellWithIdentifier("messages", forIndexPath: indexPath) as! MessagesCell
        
         if searchActive {
            
            if filtered.count != 0 {
                
                cell.userIcon.kf_setImageWithURL(NSURL(string: filtered[indexPath.row].userIcon)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: .None)
                
                cell.theDescription.text = filtered[indexPath.row].description
                cell.listingTitle.text = filtered[indexPath.row].title
                cell.time.text = filtered[indexPath.row].time
                
            }else {
                
                cell.userIcon.kf_setImageWithURL(NSURL(string: messageArray[indexPath.row].userIcon)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: .None)
                
                cell.theDescription.text = messageArray[indexPath.row].description
                cell.listingTitle.text = messageArray[indexPath.row].title
                cell.time.text = messageArray[indexPath.row].time

            }
         }else {
            
            cell.userIcon.kf_setImageWithURL(NSURL(string: messageArray[indexPath.row].userIcon)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: .None)
            
            cell.theDescription.text = messageArray[indexPath.row].description
            cell.listingTitle.text = messageArray[indexPath.row].title
            cell.time.text = messageArray[indexPath.row].time
        }
        
        return cell
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        var controller = segue.destinationViewController as! MessageViewController
        
        controller.hidesBottomBarWhenPushed = true
        
        controller.userIcon = UIImage(named: "me")

    }
    

}
