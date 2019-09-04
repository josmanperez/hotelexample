//
//  PropertyDetailViewController.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 03/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit
import Alamofire
import MapKit
import Kingfisher

class PropertyDetailViewController: UIViewController {
    
    var property: Property?
    let request = "https://private-anon-b0f95b2571-practical3.apiary-mock.com/properties/"
    
    @IBOutlet weak var backgrounPropertyImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var overallRating: UILabel!
    @IBOutlet weak var addressLine: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startActivityIndicator()
        if let _id = property?.id {
            Alamofire.request("\(request)\(_id)").responseJSON { response in
                
                Loading.stop()
                
                if response.result.isSuccess {
                    guard let data = response.data else { return }
                    
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(ApiPropertyDetail.self, from: data)
                    
                    self.configurePropertyDetailView(propertyDetail: result)

                } else {
                    
                }
                
            }
        }

    }
    
    // - MARK: Configure Views
    
    func configurePropertyDetailView(propertyDetail: ApiPropertyDetail) {
        
        if let _images = property?.images {
            configureImage(with: _images)
        }
        self.name.text = propertyDetail.name
        if let _rating = property?.rating?.overall {
            self.overallRating.text = "\(_rating)"
        } else {
            self.overallRating.text = "-"
        }
        
        configureAddress(propertyDetail: propertyDetail)
        
    }
    
    fileprivate func configureAddress(propertyDetail: PropertyDetail) {
        var direction = ""
        
        if let _addressFirst = propertyDetail.addressFirst, !_addressFirst.isEmpty {
            direction = "\(_addressFirst), "
        }
        if let _addressSecond = propertyDetail.addressSecond, !_addressSecond.isEmpty {
            direction += "\(_addressSecond), "
        }
        if let _city = property?.location.city, !_city.isEmpty {
            direction += "\(_city), "
        }
        addressLine.text = "\(direction) \(property?.location.country ?? "")"
        if addressLine.text?.count == 0 || addressLine.text?.isEmpty ?? true {
            addressLine.isHidden = true
        }
    }
    
    /// Set image using asynclibrary for the background
    fileprivate func configureImage(with images: [PropertyImage]) {
        if !images.isEmpty, let imageResource = images.first {
            let urlString = "\(imageResource.prefix)\(imageResource.suffix)"
            let url = URL(string: urlString)
            backgrounPropertyImage.kf.indicatorType = .activity
            backgrounPropertyImage.kf.setImage(with: url) {
                result in
                switch result {
                case .success(_):
                    self.backgrounPropertyImage.contentMode = .scaleAspectFill
                case .failure(_):
                    self.backgrounPropertyImage.image = UIImage(named: ImagesResources.propertyDefault)
                    self.backgrounPropertyImage.contentMode = .scaleAspectFit
                }
                
            }
        }
    }
    
    func startActivityIndicator() {
        guard let y = navigationController?.navigationBar.frame.height else { return }
        let frame = CGRect(origin: CGPoint(x: view.frame.origin.x, y: y), size: view.frame.size)
        if let spinnerView = Loading.starts(frame: frame) {
            view.addSubview(spinnerView)
        }
        //let backgroundView = UIView(frame: frame)
        //backgroundView.backgroundColor = UIColor.purple
        //view.addSubview(backgroundView)
        //view.addSubview(Loading.starts(frame: frame))
    }

}
