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

class PropertyDetailViewController: UIViewController {
    
    var property: Property?
    let request = "https://private-anon-b0f95b2571-practical3.apiary-mock.com/properties/"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startActivityIndicator()
        
        if let _id = property?.id {
            Alamofire.request("\(request)\(_id)").responseJSON { response in
                
                //Loading.stop(referenceView: self.contentView)
                Loading.stop()
                
                if response.result.isSuccess {
                    guard let data = response.data else { return }
                    //print("JSON: \((response.result.value) ?? "Error")")
                    
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(ApiPropertyDetail.self, from: data)

                    //print("\(String(describing: result))")
                } else {
                    
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
