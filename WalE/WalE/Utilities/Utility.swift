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
}
