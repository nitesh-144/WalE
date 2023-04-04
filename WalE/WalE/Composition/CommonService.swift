//
//  CommonService.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Foundation

protocol CommonServiceProtocol{
    
    var apiService: NetworkModuleProtocol { get set }
    var offlineStoreService: OfflineServiceProtocol { get set }
    
    func getImageOfTheDay(imageRecord: @escaping (ImageDataModel) -> Void)
}

class CommonService: CommonServiceProtocol{
    
    var apiService: NetworkModuleProtocol
    var offlineStoreService: OfflineServiceProtocol
    
    init(withApiService apiService: NetworkModuleProtocol, offlineStore dbStore: OfflineServiceProtocol){
        self.apiService = apiService
        self.offlineStoreService = dbStore
    }
    
    func getImageOfTheDay(imageRecord: @escaping (ImageDataModel) -> Void) {
        
        let pastRecordDate = UserDefaultsManager.shared.getLastRecordSavedDate()
        let pastRecordFlag = pastRecordDate != nil
        let isToFetchFreshImageData = !pastRecordFlag || Utlity.checkTodayWithSavedRecordDate(savedRecordDate: pastRecordDate!)
        
        if isToFetchFreshImageData{
            //Show loading
            print("\nGetting from server\n")
            apiService.getImageOfTheDay {[weak self] imageData, errorCases in
                //Remove loading
                switch errorCases{
                case .internetConnectionError, .apiServiceError:
                    if pastRecordFlag{
                        //connection issue or something went wrong, use past day record
                        //show alert and on click on that get Image data from DB
                    }else{
                        //nothing to show
                        //show alert and on click on reload api
                    }
                case .none:
                    imageRecord(imageData!)
                    self?.offlineStoreService.clearDB()
                    self?.offlineStoreService.saveImageDataToDB(imageModel: imageData!)
                    UserDefaultsManager.shared.saveCurentDate()
                }
            }
        }else{
            print("\nGetting from DB\n\n")
            if let offlineRecord = offlineStoreService.getImageData(){
                imageRecord(offlineRecord)
            }else{
                //show alert - Not able to fetch data, on click - just Dismiss
            }
        }
    }
}
