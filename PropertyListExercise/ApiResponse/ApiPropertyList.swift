//
//  ApiResponse.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 29/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

/// Class for handle API response objects of type property
class ApiPropertyList: Decodable {
    let properties:[Property]
}
