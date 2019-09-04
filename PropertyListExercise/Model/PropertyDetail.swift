//
//  PropertyDetail.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 03/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation

/// class for storing detail of properties
class PropertyDetail: Property {
    
    enum PropertyDetailCodingKeys: String, CodingKey {
        case description
        case detailImages = "images"
        case addressFirst = "address1"
        case addressSecond = "address2"
        case policies
        case latitude
        case longitude
    }
    
    var description: String
    var addressFirst: String?
    var addressSecond: String?
    var policies:[Policies]?
    var latitude: Double?
    var longitude: Double?
    //var mainImage: PropertyImage?
    var detailImages:[PropertyImage]
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PropertyDetailCodingKeys.self)
        self.description = try container.decode(String.self, forKey: .description)
        self.addressFirst = try container.decode(String.self, forKey: .addressFirst)
        self.addressSecond = try container.decode(String.self, forKey: .addressSecond)
        let _policies = try container.decode([String].self, forKey: .policies)
        var policiesArray:[Policies] = []
        _policies.forEach { (policy) in
            if let _policy = Policies.init(rawValue: policy) {
                policiesArray.append(_policy)
            }
        }
        self.policies = policiesArray
        let _latitude = try container.decode(String.self, forKey: .latitude)
        self.latitude = Double(_latitude)
        let _longitude = try container.decode(String.self, forKey: .longitude)
        self.longitude = Double(_longitude)
        self.detailImages = try container.decode([PropertyImage].self, forKey: .detailImages)
        try super.init(from: decoder)
    }
    
}
