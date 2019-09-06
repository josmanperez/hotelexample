//
//  ApiRest.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 06/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

protocol ApiRest {
    associatedtype T
    var urlServer: String { get }
    func request(completionHandler: @escaping ((Bool, T?) -> Void))
}
