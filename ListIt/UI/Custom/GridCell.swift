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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(imageViewContent)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageViewContent.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
    }
    
}
