//
//  DateConverter.swift
//  FFVE
//
//  Created by Margarita Blanc on 11/12/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import UIKit



final class DateConverter {
    
    func sort(events: [EventItem]) -> [EventItem]{
        
        let sorted = events.sorted(by: { $0.firstDate.compare($1.firstDate) == .orderedAscending })
        
        return sorted
    }
    
    func getDateMonthYear() -> (String, String){
        let now = Date()
        
        let monthFormatter = DateFormatter()
        
        let yearFormatter = DateFormatter()
        
        monthFormatter.timeZone = TimeZone.current
        yearFormatter.timeZone = TimeZone.current
        
        monthFormatter.dateFormat = "MM"
        yearFormatter.dateFormat = "yyyy"
        
        let monthString = monthFormatter.string(from: now)
        let yearString = yearFormatter.string(from: now)
        
        return (monthString, yearString)
    }
    
    func getDategetDateMonthYearShort() -> (String, String){
        let now = Date()

         let formatter = DateFormatter()
        let yearFormatter = DateFormatter()

         formatter.timeZone = TimeZone.current
        yearFormatter.timeZone = TimeZone.current

         formatter.dateFormat = "MM"
        yearFormatter.dateFormat = "yy"

         let dateString = formatter.string(from: now)
        let yearString = yearFormatter.string(from: now)
        
        return (dateString, yearString)
    }
}
