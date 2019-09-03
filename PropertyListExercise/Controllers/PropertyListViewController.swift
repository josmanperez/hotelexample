//
//  ViewController.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 28/08/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit
import Alamofire

class PropertyListViewController: UIViewController {
    
    let activityView = UIActivityIndicatorView(style: .gray)
    let showPropertySegue = "showPropertyDetail"
    let request = "https://private-anon-b0f95b2571-practical3.apiary-mock.com/cities/1530/properties/"
    var results: ApiPropertyList?
    
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: PropertyListCellTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PropertyListCellTableViewCell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        createActivityIndicatory()
        
        isLoading(active: true)
        
        Alamofire.request(request).responseJSON { response in
            self.isLoading(active: false)
            
            if response.result.isSuccess {
                guard let data = response.data else { return }
                print("JSON: \((response.result.value) ?? "Error")")
                
                let decoder = JSONDecoder()
                self.results = try! decoder.decode(ApiPropertyList.self, from: data)
                
                print("\(String(describing: self.results))")
            
                self.tableView.reloadData()
                
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

extension PropertyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showPropertySegue, sender: nil)
    }
    
    
}

extension PropertyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let _result = results else { return 0 }
        return _result.properties.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let property = results?.properties[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: PropertyListCellTableViewCell.reuseIdentifier, for: indexPath) as? PropertyListCellTableViewCell {
            cell.property = property
            cell.backgroundColor = UIColor.clear
            cell.configureCell()
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PropertyListCellTableViewCell.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

