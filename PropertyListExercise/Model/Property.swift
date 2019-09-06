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
enum PropertyType: String, Decodable {
    case unknown = "Unknown"
    case hotel = "Hotel"
    case apartment = "Apartment"
    case hostal = "Hostel"
    case guesthouse = "Guesthouse"
    
    init(rawValue: String) {
        switch rawValue.lowercased() {
        case PropertyType.hotel.rawValue.lowercased():
            self = .hotel
        case PropertyType.apartment.rawValue.lowercased():
            self = .apartment
        case PropertyType.hostal.rawValue.lowercased():
            self = .hostal
        case PropertyType.guesthouse.rawValue.lowercased():
            self = .guesthouse
        default:
            self = .unknown
        }
    }
    
    var description: String {
        get {
            return self.rawValue
        }
    }
}

// MARK: Classes for the model

/// Class for overall rating
class OverallRating: Codable {
    var overall: Int?
    var numberOfRatings: Int?
}

/// Class for handling the property city
class PropertyCity: Codable {
    enum CodingKeys: String, CodingKey {
        case city = "name"
        case country
    }
    
    var city: String
    var country: String
}

/// Class for imagen inside property list objects
class PropertyImage: Codable {
    var suffix: String
    var prefix: String
}

/// Class property to handle list of property objects
class Property: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case type
        case rating = "overallRating"
        case images
        case location = "city"
    }
    
    var id: String
    var name: String
    var rating: OverallRating?
    var type: PropertyType
    var location: PropertyCity
    var images:[PropertyImage]
    
}

