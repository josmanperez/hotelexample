//
//  File.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 05/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import Foundation
import MapKit

/// Class for handle all functions related with Mapkit
class MapHelper: NSObject, MKAnnotation {
    let title: String?
    let rating: OverallRating?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, rating: OverallRating?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.rating = rating
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        if let _rating = rating?.overall, let _total = rating?.numberOfRatings {
            return "rating: \(_rating) of \(_total) rates"
        } else {
            return "no ratings"
        }
    }
}


