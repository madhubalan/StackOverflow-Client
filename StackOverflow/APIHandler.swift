//
//  APIHandler.swift
//  StackOverflow
//
//  Created by Madhu on 05/12/16.
//  Copyright © 2016 com.task. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

// CONST

let BASE_URL = "https://api.stackexchange.com/2.2/"
let PAGE = 1
let PAGE_SIZE = 100
let SO_KEY = "XgDZBnrxu4aCUaAeFBdToA(("
let REDIRECT_URL = "https://stackexchange.com/oauth/login_success"
let ACCESS_TOKEN = "access_token"

public protocol EnumPrintable {
    func getTitle()->String
    func getValue()->String
    static func allItems()->[String]
}

enum AllQuestionSortType :Int, EnumPrintable
{
    case Activity
    case Votes
    case Creation
    case Hot
    
    func getTitle()->String
    {
        switch self {
            
        case .Activity: return "Activity"
        case .Votes: return "Votes"
        case .Creation: return "Creation"
        case .Hot: return "Hot"
            
        }
    }
    
    func getValue()->String
    {
        switch self {
            
        case .Activity: return "activity"
        case .Votes: return "votes"
        case .Creation: return "creation"
        case .Hot: return "hot"
            
        }
    }

    static func allItems()->[String]
    {
        return ["Activity", "Votes", "Creation", "Hot"]
    }
}

enum OwnQuestionSortType : Int, EnumPrintable
{
    case Activity
    case Votes
    case Creation
    
    func getTitle()->String
    {
        switch self {
            
        case .Activity: return "Activity"
        case .Votes: return "Votes"
        case .Creation: return "Creation"
            
        }
    }
    func getValue()->String
    {
        switch self {
            
        case .Activity: return "activity"
        case .Votes: return "votes"
        case .Creation: return "creation"
        }
    }

    
    static func allItems()->[String]
    {
        return ["Activity", "Votes", "Creation"]
    }
}


class APIHandler: NSObject {
    
    
    class func getAllQuestoin(sType : AllQuestionSortType, tagged : String?, onSuccess:@escaping (QuestionDetails) -> Void, onError:@escaping (NSError?) -> Void)
    {
        var tagParam = ""
        if let tag = tagged
        {
            tagParam = "tagged=\(tag)&"
        }
       let url = BASE_URL + "questions?page=\(PAGE)&pagesize=\(PAGE_SIZE)&order=desc&sort=\(sType.getValue())&site=stackoverflow&\(tagParam)key=\(SO_KEY)"
        
        Alamofire.request(url, method:.get, parameters:nil, encoding:URLEncoding.default).responseObject { (response: DataResponse<QuestionDetails>) in
            
            if response.result.isSuccess
            {
                onSuccess(response.result.value!)
            }
            else
            {
                onError(response.result.error as NSError?)
            }
        }
    }
    
    class func getOwnQuestoin(sType : OwnQuestionSortType, onSuccess:@escaping (QuestionDetails) -> Void, onError:@escaping (NSError?) -> Void)
    {
        if let token = UserDefaults.standard.object(forKey: ACCESS_TOKEN) as? String
        {
            let url = BASE_URL + "me/questions?key=\(SO_KEY)&site=stackoverflow&page=\(PAGE)&pagesize=\(PAGE_SIZE)&order=desc&sort=\(sType.getValue())&access_token=\(token)&filter=default"
            
            Alamofire.request(url, method:.get, parameters:nil, encoding:URLEncoding.default).responseObject { (response: DataResponse<QuestionDetails>) in
                
                if response.result.isSuccess
                {
                    onSuccess(response.result.value!)
                }
                else
                {
                    onError(response.result.error as NSError?)
                }
            }
        }
    }

}
