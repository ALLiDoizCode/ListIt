//
//  MessagesCell.swift
//  ListIt
//
//  Created by Jonathan Green on 1/14/16.
//  Copyright © 2016 Jonathan Green. All rights reserved.
//

import UIKit

class MessagesCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var theDescription: UILabel!
 
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dispatch_async(dispatch_get_main_queue(), {
            
            self.userIcon.layer.cornerRadius = self.userIcon.frame.height/2
            self.userIcon.layer.masksToBounds = true
            
        });
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
