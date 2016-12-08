//
//  NSDate+Extension.swift
//  StackOverflow
//
//  Created by Madhu on 07/12/16.
//  Copyright © 2016 com.task. All rights reserved.
//

import Foundation

extension Date
{
    
    func convertLocalTimestamp() -> String
    {
        let timeDiff = Date().timeIntervalSince(self)
        let noOfS = Int(timeDiff), noOfMin = Int(timeDiff / 60), noOfH = Int(timeDiff / 3600), noOfD = Int(timeDiff / 86400), noOfW = Int(timeDiff / 604800), noOfMon = Int(timeDiff / 2419200), noOfY = Int(timeDiff / 29030400)
        if (noOfS <= 60)
        {
            return  "\(noOfS) sec ago"
        }
        else if (noOfMin <= 60)
        {
            return "\(noOfMin) min ago"
        }
        else if (noOfH <= 24)
        {
            return "\(noOfH) h ago"
        }
            // To check for Days
        else if (noOfD <= 7)
        {
            return "\(noOfD) d ago"
        }
            
            // To check for weeks
        else if (noOfW <= 4)
        {
            return "\(noOfW) w ago"
        }
            
            // To check for months
        else if (noOfMon <= 12)
        {
            return "\(noOfMon) mon ago"
            
        }
            
            // To check for years
        else        {
            
            return "\(noOfY) y ago"
        }
    }

}
