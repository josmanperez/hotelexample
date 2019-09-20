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
    
    @IBOutlet weak var contentsView: UIView!
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
    
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var propertyMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //contentsView.alpha = 0
        if !Connectivity.shared.isAvailable() {
            showToast(title: "error".localizedString(), message: "no_internet".localizedString())
        }
        navigationItem.title = property?.name
        configureCollectionView()
        fetchPropertyDetail()
        
    }
    
    // - MARK: Fetch results
    
    fileprivate func fetchPropertyDetail() {
        startActivityIndicator()
        guard let _id = property?.id else {
            showToast(title: "error".localizedString(), message: "error_fetching".localizedString())
            return
        }
        let apiRequest = ApiRestClient<ApiPropertyDetail>(urlServer: "\(ApiPropertyDetail.requestUrl)/\(_id)")
        DispatchQueue.global(qos: .userInitiated).async {
            apiRequest.request(completionHandler: { (success, item) in
                DispatchQueue.main.async {
                    if success {
                        guard let _item = item else {
                            self.showToast(title: "error".localizedString(), message: "error_fetching".localizedString())
                            return
                        }
                        self.propertyDetail = _item
                        self.configurePropertyDetailView(propertyDetail: _item)
                        self.configureMap(with: _item)
                        self.collectionViewImages.reloadData()
                    } else {
                        self.showToast(title: "error".localizedString(), message: "error_fetching".localizedString())
                    }
                    Loading.stop()
                }
            })
        }
    }
    
    // - MARK: Toast View
    
    func showToast(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss".localizedString(), style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    // - MARK: Configure Views
    
    fileprivate func configureCollectionView() {
        let nibCell = UINib(nibName: ImageCollectionViewCell.nibName, bundle: nil)
        collectionViewImages.register(nibCell, forCellWithReuseIdentifier: collectionCellReuseIdentifier)
    }
    
    /// Configure the map, load the property and show the pin.
    /// This has to be done on a background thread in order to not overload the mainthread
    /// And not freeze user interface
    fileprivate func configureMap(with propertyDetail: ApiPropertyDetail) {
        // Create a loading view
        let spinner = UIActivityIndicatorView(frame: CGRect.zero)
        spinner.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        spinner.style = .gray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        propertyMap.addSubview(spinner)
        NSLayoutConstraint(item: spinner, attribute: .leading, relatedBy: .equal, toItem: propertyMap, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .trailing, relatedBy: .equal, toItem: propertyMap, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .bottom, relatedBy: .equal, toItem: propertyMap, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .top, relatedBy: .equal, toItem: propertyMap, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        guard let _latitude = propertyDetail.latitude, let _longitude = propertyDetail.longitude else {
            let view = UIView(frame: self.propertyMap.frame)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = UIColor.white
            view.alpha = 0.8
            let label = UILabel()
            label.text = "No property location found"
            label.font = UIFont(name: "Helvetica-Neue", size: 5)
            view.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
            self.propertyMap.addSubview(view)
            NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self.propertyMap, attribute: .leading, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self.propertyMap, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.propertyMap, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.propertyMap, attribute: .top, multiplier: 1, constant: 0).isActive = true
            return
        }
        // Call the background thread to search for the location
        DispatchQueue.global(qos: .background).async {
            
            let location = CLLocation(latitude: _latitude, longitude: _longitude)
            let artwork = MapHelper(title: propertyDetail.name, rating: self.property?.rating, coordinate: CLLocationCoordinate2D(latitude: _latitude, longitude: _longitude))
            DispatchQueue.main.async { [weak self] in
                self?.centerMapOnLocation(location: location)
                self?.propertyMap.addAnnotation(artwork)
                spinner.stopAnimating()
            }
        }
        
    }
    
    fileprivate func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.propertyMap.setRegion(coordinateRegion, animated: true)
    }
    
    fileprivate func configurePropertyDetailView(propertyDetail: ApiPropertyDetail) {
        
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

