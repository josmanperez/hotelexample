//
//  ApiResponse.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 29/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Alamofire

/// Class for handle API response objects of type property list
class ApiPropertyList: Decodable {
    static let requestUrl = "https://private-anon-b0f95b2571-practical3.apiary-mock.com/cities/1530/properties/"
    let properties:[Property]
}
