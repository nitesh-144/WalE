//
//  OfflineStoreClient.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Foundation

protocol OfflineServiceProtocol{
    func saveImageDataToDB(imageModel model: ImageDataModel)
    func clearDB()
    func getImageData() -> ImageDataModel?
}

