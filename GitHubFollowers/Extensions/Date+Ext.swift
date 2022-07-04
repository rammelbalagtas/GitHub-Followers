//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Rammel on 2022-07-04.
//

import Foundation

extension Date {
    
    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyy"
        dateFormatter.locale = Locale(identifier: "en_CA")
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}
