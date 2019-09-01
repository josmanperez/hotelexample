//
//  PropertyListCellTableViewCell.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 31/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit

class PropertyListCellTableViewCell: UITableViewCell {
    
    public static let reuseIdentifier : String = "propertyListCell"
    public static let nibName : String = "PropertyListViewCell"
    public static let height : CGFloat = 206.0

    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var propertyType: UILabel!
    @IBOutlet weak var propertyCost: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var ratingView: UIView! {
        didSet {
            ratingView.layer.cornerRadius = 5.0
            ratingView.layer.maskedCorners = [.layerMinXMaxYCorner]
            ratingView.layer.masksToBounds = true
        }
    }
    
    var property:Property?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    // MARK: - Functions to configure Views
    
    /// Method to configure the tableViewCell itself
    fileprivate func configureView() {
//        self.contentView.layer.cornerRadius = 5.0
//        self.contentView.layer.borderWidth = 1.0
//        self.contentView.layer.borderColor = UIColor.clear.cgColor
//        self.contentView.layer.masksToBounds = true
//        self.layer.masksToBounds = false
        

        
    }
    
    
    /// Method to configure the view with a Property List Object
    /// - Returns: Void
    func configureCell() {
        guard let _property = property else { return }
        propertyName.text = _property.name
        propertyType.text = _property.type.description
        if let _rating = _property.rating.overall {
            rating.text = "\(_rating)"
        } else {
            rating.text = "-"
        }
    }

}
