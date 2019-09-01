//
//  PropertyListCellTableViewCell.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 31/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit

class PropertyListCellTableViewCell: UITableViewCell {

    @IBOutlet weak var propertyName: UILabel!
    @IBOutlet weak var propertyType: UILabel!
    @IBOutlet weak var propertyCost: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    var property:Property?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
