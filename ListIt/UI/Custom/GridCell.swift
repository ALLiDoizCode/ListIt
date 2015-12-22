//
//  GridCell.swift
//  ListIt
//
//  Created by Jonathan Green on 12/14/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {
    
    var imageViewContent : UIImageView = UIImageView()
    var type : UIImageView = UIImageView()
    
    /*required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clearColor()
        contentView.addSubview(imageViewContent)
        contentView.insertSubview(type, aboveSubview: imageViewContent)
    }*/
    
    
    override func awakeFromNib() {
        
        
        backgroundColor = UIColor.clearColor()
        contentView.addSubview(imageViewContent)
        contentView.insertSubview(type, aboveSubview: imageViewContent)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewContent.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        imageViewContent.layer.borderColor = UIColor.whiteColor().CGColor
        imageViewContent.layer.borderWidth = 2
        imageViewContent.layer.cornerRadius = 2
        imageViewContent.layer.masksToBounds = true
        imageViewContent.clipsToBounds = true
        
        type.frame = CGRectMake(5, 5, 25, 25)
        type.layer.borderColor = UIColor.whiteColor().CGColor
        type.layer.borderWidth = 1
        type.layer.cornerRadius = type.layer.frame.height/2
        type.layer.masksToBounds = true
    }
    
}
