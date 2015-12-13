//
//  Client.swift
//  ListIt
//
//  Created by Jonathan Green on 12/9/15.
//  Copyright © 2015 Jonathan Green. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManger {
    
    func pay(token:String){
        
        let parameters = [
            "access_token":token,
            "email":"venmo@venmo.com",
            "note":"A message to accompany the payment.",
            "amount": 0.10
        ]
        
        Alamofire.request(.POST,"https://sandbox-api.venmo.com/v1/payments", parameters: parameters as? [String : AnyObject]) .responseJSON { response in
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let JSON = response.result.value {
                print("JSON: \(JSON)")
            }
        }
    }

}
