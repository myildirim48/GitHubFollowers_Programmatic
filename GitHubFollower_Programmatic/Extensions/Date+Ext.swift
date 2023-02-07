//
//  Date+Ext.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 1.02.2023.
//

import Foundation
extension Date {
//    func convertDateToMonthDayYear() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMM d, yyyy"
//        return dateFormatter.string(from: self)
//    }
//
    func convertDateToMonthDayYear() -> String {
        return formatted(.dateTime.month(.twoDigits).year(.defaultDigits))
    }
}
