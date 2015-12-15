//
//  GridViewController.swift
//  ListIt
//
//  Created by Jonathan Green on 12/14/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit
import Kingfisher

class GridViewController: UIViewController,CHTCollectionViewDelegateWaterfallLayout {
    
    let identifier = "GridCell"
    var items:[item] = []
    
    let parseData:getData = getData()

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        print(items.count)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCollectionView(){
        
        //parseData fill the aray for the listview items with this
        self.parseData.getItem { (items) -> Void in
            
            
            let collection :UICollectionView = self.collectionView!;
            collection.frame = screenBounds
            collection.setCollectionViewLayout(CHTCollectionViewWaterfallLayout(), animated: false)
            collection.backgroundColor = UIColor.grayColor()
            collection.registerClass(GridCell.self, forCellWithReuseIdentifier: self.identifier)
            
            dispatch_async(dispatch_get_main_queue(), {
                
                self.items = items
                
                collection.reloadData()
                
            });
            

            //the images are stored as url so as not to take up memory
            print("ItemIcon: \(items[0].icon)")
            print("UserIcon: \(items[0].userIcon)")
            print("Title: \(items[0].title)")
            print("Price: \(items[0].price)")
            print("Shares: \(items[0].shares)")
            print("Comments: \(items[0].comments)")
            
            
        }
        
    }
    
    // Mark delegates
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        var imageHeight:CGFloat!
        
        let imageView:UIImageView = UIImageView()
        
        imageView.kf_setImageWithURL(NSURL(string: items[indexPath.item].icon)!, placeholderImage: nil, optionsInfo: nil) { (image, error, cacheType, imageURL) -> () in
            
            imageHeight = image!.size.height*gridWidth/image!.size.width
        }
        
        return CGSizeMake(gridWidth, imageHeight)
    }
    
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell: GridCell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! GridCell
        cell.imageViewContent.kf_setImageWithURL(NSURL(string: items[indexPath.item].icon)!)
        cell.setNeedsLayout()
        return cell;
    }
    
   func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return items.count;
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
