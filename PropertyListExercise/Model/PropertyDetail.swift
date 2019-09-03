//
//  PropertyDetail.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 03/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

/// class for storing detail of properties
class PropertyDetail: Decodable {
    
    var description: String
    //var latitude: Double?
    //var longitude: Double?
    //var mainImage: PropertyImage?
    var images:[PropertyImage]
    
}
