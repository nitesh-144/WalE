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
    
    func getImageOfTheDay(imageData: @escaping (ImageDataModel) -> Void)
}

class CommonService: CommonServiceProtocol{
    
    var apiService: NetworkModuleProtocol
    var offlineStoreService: OfflineServiceProtocol
    
    init(withApiService apiService: NetworkModuleProtocol, offlineStore dbStore: OfflineServiceProtocol){
        self.apiService = apiService
        self.offlineStoreService = dbStore
    }
    
    func getImageOfTheDay(imageData: @escaping (ImageDataModel) -> Void) {
        
    }
}
