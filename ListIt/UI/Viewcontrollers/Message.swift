//
//  Message.swift
//  ListIt
//
//  Created by Jonathan Green on 1/7/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit
import JSQMessagesViewController

var blueColor = UIColor(red: 0.596, green: 0.749, blue: 0.804, alpha: 1)

class MessageViewController: JSQMessagesViewController {
    
    var presenter = getData()
    
    var avatar:JSQMessagesAvatarImage!
    var outgoingBubbleImageData = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.grayColor())
    var incomingBubbleImageData = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(blueColor)
    
    var messages:[JSQMessage] = [JSQMessage]()
    
    var userIcon:UIImage!
    var sellerId:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        /*var avatar:JSQMessagesAvatarImage = JSQMessagesAvatarImageFactory.avatarImageWithUserInitials("JG", backgroundColor: blueColor, textColor: UIColor.lightTextColor(), font: UIFont.systemFontOfSize(14.0), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))*/
    
        
        
        setup()
        addMessages()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadMessagesView() {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.collectionView?.reloadData()

        });

        
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


//MARK - Setup
extension MessageViewController {
    func addMessages() {
      presenter.getMessages("test") { (item) -> Void in
        
        self.messages = item
        self.reloadMessagesView()
        
        }
       
    }
    
    func setup() {
        self.senderId = UIDevice.currentDevice().identifierForVendor?.UUIDString
        self.senderDisplayName = UIDevice.currentDevice().identifierForVendor?.UUIDString

    }
}

//MARK - Data Source
extension MessageViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        self.messages.removeAtIndex(indexPath.row)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let data = messages[indexPath.row]
        switch(data.senderId) {
        case self.senderId:
            return self.outgoingBubbleImageData
        default:
            return self.incomingBubbleImageData
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        let diameter = UInt(kJSQMessagesCollectionViewAvatarSizeDefault)
        let avatarImage = JSQMessagesAvatarImageFactory.avatarImageWithImage(userIcon, diameter: diameter)
        
        let avatarImage2 = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "placeholder"), diameter: diameter)
        
        let data = messages[indexPath.row]
        switch(data.senderId) {
        case self.senderId:
            return avatarImage
        default:
            return avatarImage2
        }
        
    }
}

//MARK - Toolbar
extension MessageViewController {
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        
        presenter.sendMessage(message, sellerId: "test") { () -> Void in
            
            self.messages += [message]
            self.finishSendingMessage()
            print("pressed send")
        }
        
        
        
        
       
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
    }
}