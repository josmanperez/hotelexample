//
//  ImageCollectionViewCell.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 05/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit
import Kingfisher

class ImageCollectionViewCell: UICollectionViewCell {

    static let nibName = "ImageCollectionViewCell"
    
    @IBOutlet weak var propertyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configure(with url: URL) {
        propertyImage.kf.indicatorType = .activity
        propertyImage.kf.setImage(with: url)
    }

}
