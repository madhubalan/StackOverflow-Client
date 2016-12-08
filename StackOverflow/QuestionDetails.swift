//
//  QuestionDetails.swift
//  StackOverflow
//
//  Created by Madhu on 06/12/16.
//  Copyright © 2016 com.task. All rights reserved.
//

import UIKit
import ObjectMapper

class QuestionDetails: Mappable {

    var items : [Question]?
    var hasMore : Bool?
    var quotaMax : Int?
    var quotaRemaining : Int?
   
    
    // MARK: Init Method
    required init?(map: Map)
    {
        mapping(map: map)
    }
    
    func mapping(map: Map)
    {
        items <- map["items"]
        hasMore <- map["has_more"]
        quotaMax <- map["quota_max"]
        quotaRemaining <- map["quota_remaining"]
    }

    
}
