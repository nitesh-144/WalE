//
//  DataModels.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Foundation

protocol ImageDataModel{
    var explanation: String? { get set }
    var hdurl: String? { get set }
    var title: String? { get set }
    var url: String? { get set }
    var imageContentData: Data? { get set }
}

struct PicOfTheDay: ImageDataModel, Codable{
    var explanation: String?
    var hdurl: String?
    var title: String?
    var url: String?
    var imageContentData: Data?
}
