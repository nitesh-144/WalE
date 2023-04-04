//
//  NetworkClient.swift
//  WalE
//
//  Created by Deepika Vyas on 04/04/23.
//

import Foundation

protocol NetworkModuleProtocol{
    func getImageOfTheDay(completion: @escaping (PicOfTheDay?, NetworkErrorType) -> Void)
}

class ApiClient: NetworkModuleProtocol{
    
    private init(){}
    
    static let shared: ApiClient = ApiClient()
    
    func getImageOfTheDay(completion: @escaping (PicOfTheDay?, NetworkErrorType) -> Void) {
        URLSession.shared.dataTask(with: APIRequestType.getImageOfTheDay.makeAPIRequest()!) { responseData, urlResponse, error in
            if error == nil{
                if let httpResponse = urlResponse as? HTTPURLResponse, (200 ... 300).contains(httpResponse.statusCode){
                    do{
                        let apiResponseModel  = try JSONDecoder().decode(PicOfTheDay.self, from: responseData!)
                        completion(apiResponseModel, .none)
                    }catch{
                        completion(nil, .apiServiceError)
                    }
                }else{
                    completion(nil, .apiServiceError)
                }
            }else{
                completion(nil, .apiServiceError)
            }
        }.resume()
    }
}
