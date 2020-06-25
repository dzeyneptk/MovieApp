//
//  DetailVC.swift
//  MovieApp
//
//  Created by Zeynebim on 24.06.2020.
//  Copyright © 2020 Zeynebim. All rights reserved.
//

import UIKit
import Firebase
import AlamofireImage
import Alamofire

class DetailVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableViewDetails: UITableView!
    @IBOutlet weak var imageViewPoster: UIImageView!
    
    // MARK: - Private Parameters
    private var data: [String] = []
    var movieDetailVM = MovieDetailVM()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        Gradient.shared.addGradientToView(view: view)
        data.removeAll()
        data.append("Movie Name: " + (movieDetailVM.getString ?? "") )
        data.append("Imdb: " + (movieDetailVM.imdbRating ?? "") )
        data.append("Realise time: " + (movieDetailVM.released ?? ""))
        data.append("Plot:" + (movieDetailVM.plot ?? ""))
        data.append("Actors: " + (movieDetailVM.actors ?? "") )
        data.append("Country: " + (movieDetailVM.country ?? "") )
        movieDetailVM.posterDelegate = self
        movieDetailVM.getImage(url: movieDetailVM.poster ?? "")
        self.tableViewDetails.reloadData()
        Analytics.logEvent("movie_details", parameters: [
            "name": movieDetailVM.getString ?? "" as NSObject,
            "imdbrating": movieDetailVM.imdbRating ?? "" as NSObject,
            "actors": movieDetailVM.actors ?? "" as NSObject,
            "country": movieDetailVM.country ?? "" as NSObject,
        ])
    }
    
    // MARK: - Private Functions
    private func configureTableView(){
        self.tableViewDetails.delegate = self
        self.tableViewDetails.dataSource = self
        self.tableViewDetails.backgroundColor = UIColor.clear
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
            cell.backgroundColor = UIColor.clear
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // movieDetailVM.getMovieName(by: self.data[indexPath.row])
        
    }
}

// MARK: - PosterImageDelegate
extension DetailVC: PosterImageDelegate {
    
    func failWith(error: String?) {
        print(error ?? "")
    }
    
    func succes() {
        imageViewPoster.image = movieDetailVM.image
    }
}

