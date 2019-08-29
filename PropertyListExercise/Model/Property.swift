//
//  Property.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 28/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation


// MARK: Enum for common objects

/// Enum for managing the differents types of propeties
enum PropertyType: String {
    case unknown = "Unknown"
    case hotel = "Hotel"
    case apartment = "Apartment"
    case hostal = "Hostel"
    case guesthouse = "Guesthouse"
    
    init(rawValue: String) {
        switch rawValue {
        case PropertyType.hotel.rawValue:
            self = .hotel
        case PropertyType.apartment.rawValue:
            self = .apartment
        case PropertyType.hostal.rawValue:
            self = .hostal
        case PropertyType.guesthouse.rawValue:
            self = .guesthouse
        default:
            self = .unknown
        }
    }
}

// MARK: Classes for the model

/// Class for overall rating
class OverallRating: Codable {
    var overall: Int?
    var numberOfRating: Int?
}

/// Class for handling the property city
class PropertyCity: Codable {
    var city: String?
    var name: String?
    var country: String?
}

/// Class property to handle objects
struct Property {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case latitude
        case longitude
        //case description
        //case firstLineAddress = "address1"
        //case secondLineAddress = "address2"
        //case directions
    }
    
    var id: String
    var name: String
    var latitude: String
    var longitude: String
    //var description: String
    //var rating:[OverallRating]
    
}

extension Property: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.latitude = try container.decode(String.self, forKey: .latitude)
        self.longitude = try container.decode(String.self, forKey: .longitude)
    }
}

