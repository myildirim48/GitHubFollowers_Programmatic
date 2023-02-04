//
//  String+Ext.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 1.02.2023.
//

import Foundation
extension String {
    
    //We are not using this func anymore
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.init(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A"}
        return date.convertDateToMonthDayYear()
    }
}
