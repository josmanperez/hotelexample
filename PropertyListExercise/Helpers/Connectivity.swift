//
//  CodingError.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 06/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit
import Alamofire

/// Singlenton class to ask for connectivity of the device
class Connectivity {
    
    static let shared = Connectivity()
    
    private init() {  }
    
    
    /// - Returns: Bool for wheather there is internet or not
    func isAvailable() -> Bool {
        return NetworkReachabilityManager.init()?.isReachable ?? true
    }
    
    
}
