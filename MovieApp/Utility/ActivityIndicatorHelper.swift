//
//  ActivityIndicatorHelper.swift
//  MovieApp
//
//  Created by Zeynebim on 25.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class ActivityIndicator: NVActivityIndicatorViewable {
    static let shared = ActivityIndicator()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var indicator: NVActivityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0), type: NVActivityIndicatorType.lineScalePulseOut, color: UIColor.blue, padding: 2.0)
    private var topVCView = UIApplication.shared.windows.first?.rootViewController?.view
    
    func showIndicator() {
        configureIndicatorView()
        activityIndicator.startAnimating()
    }
    
    func stopIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
    
    func startEntryLoading() {
        configureEntryLoading()
        indicator.startAnimating()
    }
    
    func stopEntryLoading() {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
    }
    
    private func configureIndicatorView() {
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.center = topVCView?.center ?? CGPoint(x: 0.0, y: 0.0)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        topVCView?.addSubview(activityIndicator)
    }
    private func configureEntryLoading() {
        indicator.center = topVCView?.center ?? CGPoint(x: 0.0, y: 0.0)
        indicator.type = .lineScalePulseOut
        topVCView?.addSubview(indicator)
    }
}
