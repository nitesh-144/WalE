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
    var delegate: CommonServiceListenerProtocol? { get set }
    
    func getImageOfTheDay(imageRecord: @escaping (ImageDataModel) -> Void)
}

protocol CommonServiceListenerProtocol: AnyObject{
    func showLoader()
    func hideLoader()
    func showAlert(withTitle title: String, message: String)
}

class CommonService: CommonServiceProtocol{
    
    weak var delegate: CommonServiceListenerProtocol?
    var apiService: NetworkModuleProtocol
    var offlineStoreService: OfflineServiceProtocol
    var errorFlag: NetworkErrorType = .none
    var isPastData = false
    
    init(withApiService apiService: NetworkModuleProtocol, offlineStore dbStore: OfflineServiceProtocol){
        self.apiService = apiService
        self.offlineStoreService = dbStore
    }
    
    func getImageOfTheDay(imageRecord: @escaping (ImageDataModel) -> Void) {
        
        let pastRecordDate = UserDefaultsManager.shared.getLastRecordSavedDate()
        let pastRecordFlag = pastRecordDate != nil
        isPastData = pastRecordFlag
        let isToFetchFreshImageData = !pastRecordFlag || Utlity.checkTodayWithSavedRecordDate(savedRecordDate: pastRecordDate!)
        
        if isToFetchFreshImageData{
            //Show loading
            print("\nGetting from server\n")
            apiService.getImageOfTheDay {[weak self] imageData, errorCases in
                //Remove loading
                self?.errorFlag = errorCases
                switch errorCases{
                case .internetConnectionError, .apiServiceError:
                    if pastRecordFlag{
                        let caption = (errorCases == .internetConnectionError) ? "Network Connection Error" : "OOPS! Someting went wrong."
                        let errorMessage = "We are showing you the last saved record."
                        self?.delegate?.showAlert(withTitle: caption, message: errorMessage)
                        self?.getImageFromDB { imageData in
                            imageRecord(imageData)
                        }
                    }else{
                        self?.delegate?.showAlert(withTitle: "Error", message: "Sorry! We don't have any data at the moment to show, Please try again Later!")
                    }
                case .none:
                    imageRecord(imageData!)
                    self?.offlineStoreService.clearDB()
                    self?.offlineStoreService.saveImageDataToDB(imageModel: imageData!)
                    UserDefaultsManager.shared.saveCurentDate()
                }
            }
        }else{
            self.getImageFromDB { imageData in
                imageRecord(imageData)
            }
        }
    }
    private func getImageFromDB(completion: @escaping (ImageDataModel) -> Void){
        print("\nGetting from DB\n\n")
        if let offlineRecord = offlineStoreService.getImageData(){
            completion(offlineRecord)
        }else{
            //show alert - Not able to fetch data, on click - just Dismiss
        }
    }
}
