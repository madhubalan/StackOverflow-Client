//
//  Question.swift
//  StackOverflow
//
//  Created by Madhu on 06/12/16.
//  Copyright © 2016 com.task. All rights reserved.
//

import UIKit
import ObjectMapper

class Question: Mappable {

    var questionId : Int?
    var tags : [String]?
    var owner : Owner?
    var isAnswered : Bool?
    var viewCount : Int?
    var protectedDate : Float?
    var acceptedAnswerId : Int?
    var answerCount : Int?
    var score : Int?
    var lastActivityDate : Float?
    var creationDate : Float?
    var link : String?
    var title : String?
    
    
    // MARK: Init Method
    required init?(map: Map)
    {
        mapping(map: map)
    }
    
    func mapping(map: Map)
    {
        
        questionId <- map["question_id"]
        tags <- map["tags"]
        owner <- map["owner"]
        isAnswered <- map["is_answered"]
        viewCount <- map["view_count"]
        protectedDate <- map["protected_date"]
        acceptedAnswerId <- map["accepted_answer_id"]
        answerCount <- map["answer_count"]
        score <- map["score"]
        lastActivityDate <- map["last_activity_date"]
        creationDate <- map["creation_date"]
        link <- map["link"]
        title <- map["title"]
        
        
    }
    
}
