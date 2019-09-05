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
    
    let collectionCellReuseIdentifier = "propertyDetailImage"
    var property: Property?
    var propertyDetail: PropertyDetail?
    
    let request = "https://private-anon-b0f95b2571-practical3.apiary-mock.com/properties/"
    
    @IBOutlet weak var backgrounPropertyImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var overallRating: UILabel!
    @IBOutlet weak var addressLine: UILabel!
    @IBOutlet weak var addressLocation: UILabel!
    @IBOutlet weak var nameView: UIView!
    
    @IBOutlet weak var amenitesLabel: UILabel!
    @IBOutlet weak var amenitesStackView: UIStackView!
    @IBOutlet var amenites:[UIImageView]?
    @IBOutlet weak var amenitesAndDetailView: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var collectionViewImages: UICollectionView!
    fileprivate let sectionInsets = UIEdgeInsets(top: 0.0,
                                             left: 0.0,
                                             bottom: 00.0,
                                             right: 0.0)
    fileprivate let numberOfItems:CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibCell = UINib(nibName: ImageCollectionViewCell.nibName, bundle: nil)
        collectionViewImages.register(nibCell, forCellWithReuseIdentifier: collectionCellReuseIdentifier)
        
        startActivityIndicator()
        if let _id = property?.id {
            Alamofire.request("\(request)\(_id)").responseJSON { response in
                
                Loading.stop()
                
                if response.result.isSuccess {
                    guard let data = response.data else { return }
                    
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(ApiPropertyDetail.self, from: data)
                    self.propertyDetail = result
                    self.configurePropertyDetailView(propertyDetail: result)
                    self.collectionViewImages.reloadData()

                } else {
                    
                }
                
            }
        }

    }
    
    // - MARK: Configure Views
    
    func configurePropertyDetailView(propertyDetail: ApiPropertyDetail) {
        
        self.nameView.roundedTopCornersView()
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
        configureAmenites(propertyDetail: propertyDetail)
        descriptionLabel.text = propertyDetail.description
        amenitesAndDetailView.layoutIfNeeded()
        amenitesAndDetailView.roundedBottomCornersView()

    }
    
    fileprivate func configureAmenites(propertyDetail: PropertyDetail) {
        guard let _policites = propertyDetail.policies, let _amenitesImage = amenites else {
            amenitesStackView.isHidden = true
            return
        }

        for (_index, policy) in _policites.enumerated() {
            if _index < _amenitesImage.count {
                _amenitesImage[_index].image = UIImage(named: policy.element.image)
            }
        }
    }
    
    fileprivate func configureAddress(propertyDetail: PropertyDetail) {
        var direction = ""
        var location = ""
        
        if let _addressFirst = propertyDetail.addressFirst, !_addressFirst.isEmpty {
            direction = "\(_addressFirst)"
        }
        if let _addressSecond = propertyDetail.addressSecond, !_addressSecond.isEmpty {
            direction += ", \(_addressSecond)"
        }
        if let _city = property?.location.city, !_city.isEmpty {
            location = "\(_city)"
        }
        if let _country = property?.location.country, !_country.isEmpty {
            location += ", \(_country)"
        }
        addressLine.text = "\(direction)"
        if addressLine.text?.count == 0 || addressLine.text?.isEmpty ?? true {
            addressLine.isHidden = true
        }
        addressLocation.text = "\(location)"
        if addressLocation.text?.count == 0 || addressLocation.text?.isEmpty ?? true {
            addressLocation.isHidden = true
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

extension PropertyDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _index = propertyDetail?.images.count else {
            return 0
        }
        return _index
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellReuseIdentifier, for: indexPath) as? ImageCollectionViewCell {
            
            guard let _images = propertyDetail?.images else {
                collectionViewImages.isHidden = true
                return cell
            }
            let imageResource = _images[indexPath.row]
            let urlString = "\(imageResource.prefix)\(imageResource.suffix)"
            let url = URL(string: urlString)
            cell.configure(with: url!)
            return cell
        } else {
            return collectionView.dequeueReusableCell(withReuseIdentifier: collectionCellReuseIdentifier, for: indexPath)
        }
        
    }
    
}

extension PropertyDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        
        let witdh = (collectionView.frame.width - (sectionInsets.left + sectionInsets.right)) / numberOfItems
        
        return CGSize(width: witdh, height: collectionView.frame.height)
    }
    
  
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    
}

