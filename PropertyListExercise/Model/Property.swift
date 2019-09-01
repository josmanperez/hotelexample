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

/// Class for imagen inside property list objects
class PropertyImage: Codable {
    var suffix: String
    var prefix: String
}

/// Class property to handle list of property objects
struct Property: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating = "overallRating"
        case images
        case city
    }
    
    var id: String
    var name: String
    var rating: OverallRating
    var city: PropertyCity
    var images:[PropertyImage]
    
}

//extension Property: Decodable {
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        self.id = try container.decode(String.self, forKey: .id)
//        self.name = try container.decode(String.self, forKey: .name)
//        self.rating = try container.decode(OverallRating.self, forKey: .rating)
//    }
//}

