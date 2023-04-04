//
//  Utility.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Foundation

struct Utlity{
    static func checkTodayWithSavedRecordDate(savedRecordDate: Date) -> Bool{
        let numberOfDays = Calendar.current.dateComponents([.day], from: savedRecordDate, to: Date())
        return numberOfDays.day! >= 1
    }
    
    static func getShortDescription(fromContent content: String) -> String{
        var original = content
        let words = original.split(separator: " ")
        let shortDescriptionComponents = Array(words[0 ... 25])
        return shortDescriptionComponents.joined(separator: " ")
    }
}
