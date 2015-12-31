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

class GridViewController: UIViewController,CHTCollectionViewDelegateWaterfallLayout {
    
    let identifier = "GridCell"
    var items:[item] = []
    var itemType:[String] = ["Individual-Icon","Crowdsourced-Icon","Business-Icon-1"]
    
    let parseData:getData = getData()
    
    let imageView:UIImageView = UIImageView()
    lazy   var searchBar:UISearchBar = UISearchBar(frame: CGRectMake(0, 0, 75, 20))

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewWillAppear(animated: Bool) {
        
        
        
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
    
        cell.imageViewContent.kf_setImageWithURL(NSURL(string: items[indexPath.item].icon)!)
        cell.imageViewContent.contentMode = .ScaleAspectFill
        cell.type.image = UIImage(named: itemType[ran])
    
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
        
        searchBar.placeholder = "Type Here"
        self.navigationItem.titleView = searchBar
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
            if segue.identifier == "gotoDetail" {
                
                //let indexPaths = self.collectionView!.i
                let indexPath = sender as! Int
                
                let controller:DetailViewController = segue.destinationViewController as! DetailViewController

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
    


