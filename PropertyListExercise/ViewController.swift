//
//  ViewController.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 28/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let activityView = UIActivityIndicatorView(style: .gray)
    let request = "https://private-anon-b0f95b2571-practical3.apiary-mock.com/cities/1530/properties/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createActivityIndicatory()
        
        isLoading(active: true)
        
        Alamofire.request(request).responseJSON { response in
            self.isLoading(active: false)
            
            if response.result.isSuccess {
                guard let data = response.data else { return }
                print("JSON: \((response.result.value) ?? "Error")")
                
                let decoder = JSONDecoder()
                let property = try! decoder.decode(Response.self, from: data)
                
                print("\(property)")
            } else {
                
            }
            
        }
        
    }
    
    func createActivityIndicatory() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
    }
    
    func isLoading(active: Bool) {
        active ? activityView.startAnimating() : activityView.stopAnimating()
        
    }
    
    
}

