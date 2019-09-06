//
//  CodingError.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 06/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit
import Alamofire

class Connectivity {
    
    static let shared = Connectivity()
    
    private init() {  }
    
    func isAvailable() -> Bool {
        return NetworkReachabilityManager.init()?.isReachable ?? true
    }
    
    
}
