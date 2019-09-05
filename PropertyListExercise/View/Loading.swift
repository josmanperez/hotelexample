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
    
//    public static func start(frame: CGRect) -> UIView? {
//
//        if spinner == nil {
//            let backgroundView = UIView(frame: frame)
//            backgroundView.backgroundColor = UIColor.clear
//            spinner = UIActivityIndicatorView(frame: frame)
//            spinner?.center = backgroundView.center
//            spinner?.backgroundColor = baseColor
//            spinner?.style = style
//            spinner?.color = baseColor
//            if let _spinner = spinner {
//                backgroundView.addSubview(_spinner)
//            }
//            spinner?.startAnimating()
//            return backgroundView
//        }
//        return spinner?.superview
//    }
    
//    public static func start(frame: CGRect, view: UIView) {
//
//        if spinner == nil {
//            let backgroundView = UIView(frame: frame)
//            backgroundView.backgroundColor = UIColor.red
//            spinner = UIActivityIndicatorView(frame: frame)
//            spinner?.center = view.center
//            spinner?.backgroundColor = baseColor
//            spinner?.style = style
//            spinner?.color = baseColor
//            if let _spinner = spinner {
//                backgroundView.addSubview(_spinner)
//            }
//            view.addSubview(backgroundView)
//            spinner?.startAnimating()
//        }
//
//    }
    
//    public static func start(referenceView:UIView, style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
//        //NotificationCenter.default.addObserver(self, selector: #selector(update), name: NSNotification.Name.UIDevice.orientationDidChangeNotification, object: nil)
//        if spinner == nil {
//            //let backgroundView = UIView(frame: referenceView.frame)
//            let backgroundView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 44), size: referenceView.frame.size))
//            backgroundView.backgroundColor = UIColor.orange
//            spinner = UIActivityIndicatorView(frame: CGRect(origin: CGPoint(x: 0, y: 44), size: referenceView.frame.size))
//            //spinner = UIActivityIndicatorView(style: style)
//            spinner?.center = referenceView.center
//            spinner?.backgroundColor = backColor
//            spinner?.style = style
//            spinner?.color = baseColor
//            if let _spinner = spinner {
//                backgroundView.addSubview(_spinner)
//            }
//            let window = UIApplication.shared.keyWindow
//            window?.addSubview(backgroundView)
//            //referenceView.isHidden = true
//            spinner?.startAnimating()
//        }
//        
//        //        if spinner == nil, let window = UIApplication.shared.keyWindow {
//        //            let frame = UIScreen.main.bounds
//        //            spinner = UIActivityIndicatorView(frame: frame)
//        //            spinner!.backgroundColor = backColor
//        //            spinner!.activityIndicatorViewStyle = style
//        //            spinner?.color = baseColor
//        //            window.addSubview(spinner!)
//        //            spinner!.startAnimating()
//        //        }
//    }
//    
//    public static func start(frame:CGRect, style: UIActivityIndicatorView.Style = style, backColor: UIColor = baseBackColor, baseColor: UIColor = baseColor) {
//        //NotificationCenter.default.addObserver(self, selector: #selector(update), name: NSNotification.Name.UIDevice.orientationDidChangeNotification, object: nil)
//        if spinner == nil {
//            let backgroundView = UIView(frame: frame)
//            print("loading frame: \(frame)")
//            backgroundView.backgroundColor = UIColor.clear
//            spinner = UIActivityIndicatorView(frame: backgroundView.frame)
//            spinner?.center = backgroundView.center
//            spinner?.backgroundColor = backColor
//            spinner?.style = style
//            spinner?.color = baseColor
//            if let _spinner = spinner {
//                backgroundView.addSubview(_spinner)
//            }
//            let window = UIApplication.shared.keyWindow
//            window?.addSubview(backgroundView)
//            //referenceView.isHidden = true
//            spinner?.startAnimating()
//        }
//    }
    
    //    @objc public static func update() {
    //        if spinner != nil {
    //            stop()
    //            start()
    //        }
    //    }
    
}
