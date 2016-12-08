//
//  Owner.swift
//  StackOverflow
//
//  Created by Madhu on 06/12/16.
//  Copyright © 2016 com.task. All rights reserved.
//

import UIKit
import ObjectMapper

class Owner: Mappable {
    
    var reputation : Int?
    var userId : Int?
    var userType : String?
    var acceptRate : Int?
    var profileImage : String?
    var displayName : String?
    var link : String?
    
    // MARK: Init Method
    required init?(map: Map)
    {
        mapping(map: map)
    }
    
    func mapping(map: Map)
    {
        
        reputation <- map["reputation"]
        userId <- map["user_id"]
        userType <- map["user_type"]
        acceptRate <- map["accept_rate"]
        profileImage <- map["profile_image"]
        displayName <- map["display_name"]
        link <- map["link"]
        
    }


}
