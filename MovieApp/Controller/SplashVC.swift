//
//  ViewController.swift
//  MovieApp
//
//  Created by Zeynebim on 23.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    // MARK: - Private Parameters
    private var timeCount = 0
    
    // MARK: - Private Functions
    private func checkNetwork() {
        let status = Reach().connectionStatus()
        
        switch status {
        case .unknown, .offline:
            print("Not connected")
            let alert = UIAlertController(title: "No internet connection", message: "Check your internet connection", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            view.isUserInteractionEnabled = true
            self.present(alert, animated: true, completion: nil)
        case .online(.wwan), .online(.wiFi):
            print("Connected via WWAN")
            timerToMainPage()
        }
    }
    
    private func timerToMainPage() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeCount += 1
            if self.timeCount == 3 {
                timer.invalidate()
                self.performSegue(withIdentifier: AppConstant.segueIdentifier.splashToSearch.description, sender: nil)
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
           super.viewDidLoad()
           checkNetwork()
       }
    
    override func viewWillDisappear(_ animated: Bool) {
        ActivityIndicator.shared.startEntryLoading()
        //ActivityIndicator.shared.showIndicator()
    }
    }



