//
//  Pay.swift
//  ListIt
//
//  Created by Jonathan Green on 12/8/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import Foundation
import Parse
import Stripe


class Pay {
    
    func card(expireDate:String,cardNumber:String,cvc:String){
        
        // Initiate the card
        //var stripCard = STPCard()
        let card:STPCardParams = STPCardParams()
        let validate:STPAPIClient = STPAPIClient()
        
        // Split the expiration date to extract Month & Year
        if expireDate.isEmpty == false {
            let expirationDate = expireDate.componentsSeparatedByString("/")
            let expMonth = UInt(Int(expirationDate[0])!)
            let expYear = UInt(Int(expirationDate[1])!)
            
            // Send the card info to Strip to get the token
            card.number = cardNumber
            card.cvc = cvc
            card.expMonth = expMonth
            card.expYear = expYear
            
            validate.createTokenWithCard(card, completion: { (token, error) -> Void in
                
                if error == nil {
                    
                    //success
                    
                    
                }else{
                    
                    //there was an error
                }
                
            })
         
        }
    }
    
}
