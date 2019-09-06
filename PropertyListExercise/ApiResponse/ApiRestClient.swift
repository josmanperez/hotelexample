//
//  ApiRestClient.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 06/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Alamofire

/// Class for handle the Rest API request
class ApiRestClient<T:Decodable>: ApiRest {
    
    var urlServer: String
    
    init(urlServer: String) {
        self.urlServer = urlServer
    }
    
    /// Method to request
    /// - Returns: CompletionHandler with a tuple of Bool regarding the success and object result that conforms protocol Decodable
    func request(completionHandler: @escaping ((Bool, T?) -> Void)) {
        Alamofire.request(self.urlServer).responseJSON { response in
            
            if response.result.isSuccess {
                guard let data = response.data else {
                    completionHandler(false, nil)
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let results = try decoder.decode(T.self, from: data)
                    completionHandler(true, results)
                } catch {
                    completionHandler(false, nil)
                }
            } else {
                completionHandler(false, nil)
            }
            
        }
    }
}
