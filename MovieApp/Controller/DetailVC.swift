//
//  DetailVC.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import UIKit
import Firebase

class DetailVC: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableViewDetails: UITableView!
    @IBOutlet private weak var imageViewPoster: UIImageView!
    
    // MARK: - Private Parameters
    var movieDetailVM = MovieDetailVM()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        Gradient.shared.addGradientToView(view: view)
        movieDetailVM.getImage(url: movieDetailVM.poster ?? "")
        movieDetailVM.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    // MARK: - Private Functions
    private func configureTableView(){
        self.tableViewDetails.delegate = self
        self.tableViewDetails.dataSource = self
        self.tableViewDetails.backgroundColor = UIColor.clear
        self.tableViewDetails.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction func closeBtnTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    private func updateUI() {
        imageViewPoster.image = movieDetailVM.image
        movieDetailVM.sendAnalytics()
        InstanceID.instanceID().instanceID { (result, error) in
          if let error = error {
            print("Error fetching remote instance ID: \(error)")
          } else if let result = result {
            print("Remote instance ID token: \(result.token)")
          //  self.instanceIDTokenMessage.text  = "Remote InstanceID token: \(result.token)"
          }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieDetailVM.dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = movieDetailVM.getData(atIndex: indexPath.row)
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.textLabel?.numberOfLines = 0
        cell.backgroundColor = UIColor.clear
        return cell
    }
}

// MARK: - PosterImageDelegate
extension DetailVC: MovieDetailDelegate {
    func succes() {
        updateUI()
    }
    func failWith(error: String?) {
        print(error ?? "")
    }
}

