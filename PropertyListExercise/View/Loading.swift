//
//  Loading.swift
//  PropertyListExercise
//
//  Created by Josman Pérez Expósito on 03/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit

/// Class for creating, starting and stoping an activity indicator in
/// any view
open class Loading {
    
    internal static var spinner: UIActivityIndicatorView?
    internal static var spinnerView: UIView?
    
    public static var style: UIActivityIndicatorView.Style = .white
    public static var baseBackColor = UIColor.black.withAlphaComponent(0.5)
    public static var baseColor = UIColor.black
    
    /// Function for starting an activity indicator.
    /// - Parameter frame: Frame for the activity indicator bounds
    /// - Returns: UIView with the activity indicator center on it
    public static func starts(frame: CGRect) -> UIView? {
        if spinnerView == nil {
            spinnerView = UIView(frame: frame)
            spinnerView?.backgroundColor = UIColor.white
            spinner = UIActivityIndicatorView(frame: frame)
            spinner?.color = UIColor.black
            if let center = UIApplication.shared.keyWindow?.center {
                spinner?.center = center
            }
            if let _spinner = spinner {
                spinnerView?.addSubview(_spinner)
            }
            spinner?.startAnimating()
        }
        return spinnerView
    }
    
    /// Stops the activity indicator
    public static func stop() {
        if let _spinnerView = spinnerView {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                _spinnerView.alpha = 0
            }) { _ in
                spinner?.stopAnimating()
                _spinnerView.removeFromSuperview()
                spinner = nil
                spinnerView = nil
            }
        }
    }
    
}
