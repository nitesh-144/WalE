//
//  UserDefaultsManager.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Foundation

struct UserDefaultsConstants{
    static let IMAGE_DATA_DATE = "imageDataDate"
}

class UserDefaultsManager{
    
    private init(){}
    static let shared = UserDefaultsManager()
    
    func saveCurentDate(){
        UserDefaults.standard.set(Date(), forKey: UserDefaultsConstants.IMAGE_DATA_DATE)
        UserDefaults.standard.synchronize()
    }
    
    func getLastRecordSavedDate() -> Date?{
        guard let savedDate = UserDefaults.standard.value(forKey: UserDefaultsConstants.IMAGE_DATA_DATE) else { return nil }
        if let date = savedDate as? Date{
            return date
        }
        return nil
    }
}
