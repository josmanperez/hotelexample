//
//  File.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 04/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation


/// Enum to handle the conversion between policies and images
/// - Returns: Touple with the name and the image name resource from the assets folder
enum Policies: String {
    case childFriendly = "Child Friendly"
    case creditCardAccepter = "Credit Cards Accepted"
    case noCurfew = "No Curfew"
    case nonSmoking = "Non Smoking"
    case taxesIncluded = "Taxes Included"
    case ageRestriction = "Age Restriction"
    case petFriendly = "Pet Friendly"
    
    public var element: (name: String, image: String) {
        switch self {
        case .childFriendly:
            return (self.rawValue, ImagesResources.childFriendly)
        case .creditCardAccepter:
            return (self.rawValue, ImagesResources.creditCard)
        case .noCurfew:
            return (self.rawValue, ImagesResources.noCurfew)
        case .nonSmoking:
            return (self.rawValue, ImagesResources.nonSmoking)
        case .taxesIncluded:
            return (self.rawValue, ImagesResources.taxesIncluded)
        case .petFriendly:
            return (self.rawValue, ImagesResources.petFriendly)
        case .ageRestriction:
            return (self.rawValue, ImagesResources.ageRestriction)
        }
    }
    
}
