//
//  WesterosExtensions.swift
//  westeros
//
//  Created by Hector Aguado on 25/2/18.
//  Copyright © 2018 Hector Aguado. All rights reserved.
//

import UIKit

extension Date {
//    init(dateString: String){
//        let dateStringFormatter = DateFormatter()
//        dateStringFormatter.dateFormat = "dd-MM-yyyy"
//        dateStringFormatter.locale = Locale(identifier: "es_ES")
//        let d = dateStringFormatter.date(from: dateString)!
//        self.init(timeInterval:0, since: d)
//    }
    init (dateString: String){
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "dd-MM-yyyy"
        let d = formatter.date(from: dateString)
        self.init(timeInterval: 0, since: d!)
    }
    var stringfy : String {
        let date = self
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "dd-MM-yyyy"
        
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        var monthStr = String(month)
        if month < 10 {
            monthStr = "0" + monthStr
        }
        let year = calendar.component(.year, from: date)
        return "\(day)-\(monthStr)-\(year)"
    }
}



