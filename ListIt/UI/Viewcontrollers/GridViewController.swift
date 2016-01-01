//
//  GridViewController.swift
//  ListIt
//
//  Created by Jonathan Green on 12/14/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftEventBus

class GridViewController: UIViewController,CHTCollectionViewDelegateWaterfallLayout,UISearchBarDelegate {
    
    var items:[item] = []
    var filtered:[item] = []
    
    var searchActive : Bool = false
    
    var grabItems:getItems = getItems()
    
    let identifier = "GridCell"
    
    var itemType:[String] = ["Individual-Icon","Crowdsourced-Icon","Business-Icon-1"]
    
    let imageView:UIImageView = UIImageView()
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 75, 20))

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewWillAppear(animated: Bool) {
        
        searchActive = false
        collectionView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupSearchBar()
       
        print(items.count)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView(){
        
        
        let collection :UICollectionView = self.collectionView!;
        collection.frame = screenBounds
        collection.setCollectionViewLayout(CHTCollectionViewWaterfallLayout(), animated: false)
        
        //parseData fill the aray for the listview items with this
        SwiftEventBus.onMainThread(self, name: "Items") { (result) -> Void in
            
            let collection :UICollectionView = self.collectionView!;
            collection.frame = screenBounds
            collection.setCollectionViewLayout(CHTCollectionViewWaterfallLayout(), animated: false)
            
            let ListItems = result.object as! [item]
            
            self.items = ListItems
            
            //the images are stored as url so as not to take up memory
            print("ItemIcon: \(ListItems[0].icon)")
            print("UserIcon: \(ListItems[0].userIcon)")
            print("Title: \(ListItems[0].title)")
            print("Price: \(ListItems[0].price)")
            print("Shares: \(ListItems[0].shares)")
            print("Comments: \(ListItems[0].comments)")
            
             dispatch_async(dispatch_get_main_queue(), {
                
                 collection.reloadData()
                
                })
            
          
            
        }
        
        grabItems.itemsList()
        
        
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
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        var tempArray:[String] = []
        var tempFilter:[String] = []
        
        for var i = 0; i < items.count; i++ {
            
            tempArray.append(items[i].title)
            
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
                
                for var j = 0; j < items.count; j++ {
                    
                    if tempFilter[i] == items[j].title {
                        
                        filtered.append(items[j])
                    }
                    
                }
            }
        }
        self.collectionView.reloadData()
    }
    
    // Mark delegates
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
            imageView.kf_setImageWithURL(NSURL(string: self.items[indexPath.item].icon)!, placeholderImage: UIImage(named: "placeholder"), optionsInfo: nil) { (image, error, cacheType, imageURL) -> () in
            }
        
        if  let imageHeight:CGFloat! = imageView.image!.size.height*gridWidth/imageView.image!.size.width {
            
            return CGSizeMake(gridWidth, imageHeight)
        }
        
        
    }
    
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell: GridCell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! GridCell
    
        let ran = Int(arc4random_uniform(3))
    
    if searchActive {
        
        if filtered.count != 0 {
            
            print(filtered.count)
            cell.imageViewContent.kf_setImageWithURL(NSURL(string: filtered[indexPath.item].icon)!)
            cell.type.image = UIImage(named: itemType[ran])
        }
        
    }else {
        
        cell.imageViewContent.kf_setImageWithURL(NSURL(string: items[indexPath.item].icon)!)
        cell.type.image = UIImage(named: itemType[ran])

    }
    
        cell.imageViewContent.contentMode = .ScaleAspectFill
        cell.setNeedsLayout()
    
        return cell;
    }
    
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return items.count;
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("gotoDetail", sender: indexPath.item)
    }
    
    func setupSearchBar(){
        
        searchBar.delegate = self
        searchBar.placeholder = "Type Here"
        self.navigationItem.titleView = searchBar
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
            if segue.identifier == "gotoDetail" {
                
                //let indexPaths = self.collectionView!.i
                let indexPath = sender as! Int
                
                let controller:DetailViewController = segue.destinationViewController as! DetailViewController
                
                if searchActive {
                    
                    controller.theImage = self.filtered[indexPath].icon
                    controller.theTitle = self.filtered[indexPath].title
                    controller.thePrice = "$\(self.filtered[indexPath].price)"
                    controller.theName = "Jonathan"
                    //controller.itemDescription.text = theItem.description
                    controller.theShares = "\(self.filtered[indexPath].shares) Shares"
                    controller.theComments = "\(self.filtered[indexPath].comments) Comments"
                    
                }else {
                    
                    controller.theImage = self.items[indexPath].icon
                    controller.theTitle = self.items[indexPath].title
                    controller.thePrice = "$\(self.items[indexPath].price)"
                    controller.theName = "Jonathan"
                    //controller.itemDescription.text = theItem.description
                    controller.theShares = "\(self.items[indexPath].shares) Shares"
                    controller.theComments = "\(self.items[indexPath].comments) Comments"
                }

                
            }
        
        
    }

}
    


