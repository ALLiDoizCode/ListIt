//
//  Items.swift
//  ListIt
//
//  Created by Jonathan Green on 12/11/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import Foundation

class item {
    
    var icon:String!
    var title:String!
    var userIcon:String!
    var price:Int!
    var shares:String!
    var comments:String!
    var description:String!
    var objectId:String!
    var time:String!
    
    init(theIcon:String,theUserIcon:String,theTitle:String,theShares:String,theComments:String,thePrice:Int,theDescription:String!,theObjectId:String!,theTime:String!){
    
        icon = theIcon
        userIcon = theUserIcon
        title = theTitle
        shares = theShares
        comments = theComments
        price = thePrice
        description = theDescription
        objectId = theObjectId
        time = theTime
        
    }
}