//
//  DetailVC.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import UIKit

class DetailVC: UIViewController, DetailVMDelegate {
    func sendModel(detailVM: MovieDetailVM) {
        self.movieDetailVM = detailVM
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableViewDetails: UITableView!
    
    // MARK: - Private Parameters
    private var data: [String] = []
    var movieDetailVM = MovieDetailVM()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        data.removeAll()
        data.append(movieDetailVM.getString ?? "")
        data.append(movieDetailVM.imdbRating ?? "")
        data.append(movieDetailVM.actors ?? "")
        data.append(movieDetailVM.country ?? "")
        self.tableViewDetails.reloadData()
        
    }
    
    // MARK: - Private Functions
    private func configureTableView(){
        self.tableViewDetails.delegate = self
        self.tableViewDetails.dataSource = self
        self.tableViewDetails.backgroundColor = UIColor.white
        self.tableViewDetails.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if !(data.isEmpty){
            cell.textLabel?.text = data[indexPath.row]
            cell.textLabel?.lineBreakMode = .byWordWrapping
            cell.textLabel?.numberOfLines = 0
            
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // movieDetailVM.getMovieName(by: self.data[indexPath.row])
        
    }
}

// MARK: - MovieDetailDelegte
extension DetailVC: MovieDetailDelegate {
    
    func failWith(error: String?) {
        print(error ?? "")
    }
    
    func succes() {
        data.removeAll()
        data.append(movieDetailVM.getString ?? "")
        data.append(movieDetailVM.imdbRating ?? "")
        data.append(movieDetailVM.actors ?? "")
        data.append(movieDetailVM.country ?? "")
        self.tableViewDetails.reloadData()
    }
}
