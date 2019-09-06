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
    private let refresh = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !Connectivity.shared.isAvailable() {
           showToast()
        }
        
        setupTableView()
        
        createActivityIndicatory()
        
        Alamofire.request(request).responseJSON { response in
            self.isLoading(active: false)
            
            if response.result.isSuccess {
                guard let data = response.data else { return }
                //print("JSON: \((response.result.value) ?? "Error")")
                
                let decoder = JSONDecoder()
                self.results = try! decoder.decode(ApiPropertyList.self, from: data)
                
                //print("\(String(describing: self.results))")
            
                self.tableView.reloadData()
                
            } else {
                
            }
            
        }
        
    }
    
    func setupTableView() {
        self.tableView.register(UINib(nibName: PropertyListCellTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PropertyListCellTableViewCell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.refreshControl = refresh
        refresh.attributedTitle = NSAttributedString(string: "refresh_property_list".localizedString(), attributes: [NSAttributedString.Key.font : UIFont(name: "Helvetica-Neue", size: 10) ?? UIFont.systemFont(ofSize: 10)])
        refresh.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    func createActivityIndicatory() {
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        if !activityView.isAnimating {
            isLoading(active: true)
        }
    }
    
    func isLoading(active: Bool) {
        active ? activityView.startAnimating() : activityView.stopAnimating()
    }
    
    func showToast() {
        let alert = UIAlertController(title: "error".localizedString(), message: "no_internet".localizedString(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss".localizedString(), style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func loadData() {
        refresh.endRefreshing()
    }
    
}

extension PropertyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let property = results?.properties[indexPath.row]
        guard let _property = property else { return }
        performSegue(withIdentifier: showPropertySegue, sender: _property)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let _property = sender as? Property else { return }
        if segue.identifier == showPropertySegue {
            if let dVC = segue.destination as? PropertyDetailViewController {
                dVC.property = _property
            }
        }
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
            cell.selectionStyle = .none
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
