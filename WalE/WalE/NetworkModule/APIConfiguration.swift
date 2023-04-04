//
//  APIConfiguration.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Foundation

/*
 {"date":"2023-04-03","explanation":"What causes this unusual curving structure near the center of our Galaxy? The long parallel rays slanting across the top of the featured radio image are known collectively as the Galactic Center Radio Arc and point out from the Galactic plane.  The Radio Arc is connected to the Galactic Center by strange curving filaments known as the Arches.  The bright radio structure at the bottom right surrounds a black hole at the Galactic Center and is known as Sagittarius A*.  One origin hypothesis holds that the Radio Arc and the Arches have their geometry because they contain hot plasma flowing along lines of a constant magnetic field.  Images from NASA's Chandra X-ray Observatory appear to show this plasma colliding with a nearby cloud of cold gas.","hdurl":"https://apod.nasa.gov/apod/image/2304/GalCenRadioArc_MeerKat_1080.jpg","media_type":"image","service_version":"v1","title":"The Galactic Center Radio Arc","url":"https://apod.nasa.gov/apod/image/2304/GalCenRadioArc_MeerKat_1080.jpg"}
 */

struct APIEndPoints{
    static let baseURL: String = "https://api.nasa.gov/"
    static let picOfTheDayEndPoint: String = "planetary/apod"
    static let apiKey: String? = "DEMO_KEY"
}

enum NetworkErrorType{
    case apiServiceError
    case internetConnectionError
    case none
}

protocol APIRequestable{
    var endPoint: String { get }
    var httpMethod: String { get }
    func makeAPIRequest() -> URLRequest?
}

enum APIRequestType: APIRequestable{
    case getImageOfTheDay
    
    var endPoint: String{
        switch self{
        case .getImageOfTheDay:
            return APIEndPoints.baseURL + APIEndPoints.picOfTheDayEndPoint
        }
    }
    
    var httpMethod: String{
        switch self{
        case .getImageOfTheDay:
            return "GET"
        }
    }
    
    func makeAPIRequest() -> URLRequest? {
        
        var endPoint = endPoint
        if let apiKeyToUse = APIEndPoints.apiKey{
            endPoint += "?api_key=\(apiKeyToUse)"
        }
        guard let url = URL(string: endPoint) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
    
}
